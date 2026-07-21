{ delib, lib, pkgs, ... }:
delib.module {
  name = "system.audio";

  options = { myconfig, ... }: {
    system.audio.enable = delib.boolOption myconfig.gui.enable;
    system.audio.quantum = delib.description (delib.intOption 128) "Default PipeWire quantum (buffer size). 128 = ~2.7ms at 48kHz";
    system.audio.rate = delib.intOption 48000;
    system.audio.minQuantum = delib.intOption 32;
    system.audio.maxQuantum = delib.intOption 8192;
    system.audio.performanceGovernor = delib.description (delib.boolOption true) "Set CPU governor to 'performance' for low-latency audio";
    system.audio.proAudio = delib.description (delib.boolOption true) "Auto-set ALSA card to pro-audio profile (direct access, no mixing)";
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

    powerManagement.cpuFreqGovernor = lib.mkIf cfg.performanceGovernor "performance";

    users.users.${myconfig.constants.username}.extraGroups = [
      "audio"
      "realtime"
    ];
  };
}
