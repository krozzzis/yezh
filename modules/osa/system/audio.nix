{ delib, lib, pkgs, config, ... }:
delib.module {
  name = "osa.system.audio";

  options = { myconfig, ... }: {
    osa.system.audio.enable = delib.boolOption myconfig.user.gui.enable;
    osa.system.audio.quantum = delib.description (delib.intOption 128) "Default PipeWire quantum (buffer size). 128 = ~2.7ms at 48kHz";
    osa.system.audio.rate = delib.intOption 48000;
    osa.system.audio.minQuantum = delib.intOption 32;
    osa.system.audio.maxQuantum = delib.intOption 8192;
    osa.system.audio.performanceGovernor = delib.description (delib.boolOption true) "Prefer the CPU performance mode for low-latency audio (static governor, or power-profiles-daemon's 'performance' profile if that service is enabled)";
    osa.system.audio.proAudio = delib.description (delib.boolOption true) "Auto-set ALSA card to pro-audio profile (direct access, no mixing)";
  };

  nixos.ifEnabled = { myconfig, cfg, ... }: {
    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;

      extraConfig.pipewire = {
        "92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = cfg.rate;
            "default.clock.quantum" = cfg.quantum;
            "default.clock.min-quantum" = cfg.minQuantum;
            "default.clock.max-quantum" = cfg.maxQuantum;
          };
        };
      };

    };

    services.pipewire.wireplumber.extraConfig."99-pro-audio" = lib.mkIf cfg.proAudio {
      "monitor.alsa.rules" = [{
        matches = [{ "device.name" = "~alsa_card.*"; }];
        actions = {
          "update-props" = {
            "api.alsa.use-acp" = true;
            "api.acp.auto-profile" = true;
            "api.acp.default-profile" = "pro-audio";
          };
        };
      }];
    };

    security.rtkit.enable = true;

    environment.systemPackages = with pkgs; [
      pipewire
      pipewire.jack
      qjackctl
    ];

    boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];

    # power-profiles-daemon owns the governor once it's running and will
    # override a static one as the user switches profiles, so defer to its
    # own "performance" profile instead of fighting it for control.
    powerManagement.cpuFreqGovernor =
      lib.mkIf (cfg.performanceGovernor && !config.services.power-profiles-daemon.enable) "performance";

    systemd.services.audio-performance-profile =
      lib.mkIf (cfg.performanceGovernor && config.services.power-profiles-daemon.enable) {
        description = "Select the power-profiles-daemon performance profile for low-latency audio";
        wantedBy = [ "multi-user.target" ];
        after = [ "power-profiles-daemon.service" ];
        requires = [ "power-profiles-daemon.service" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance";
        };
      };

    users.users.${myconfig.user.constants.username}.extraGroups = [
      "audio"
      "realtime"
    ];
  };
}
