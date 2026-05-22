# /home/krozzzis/yezh/modules/system/power-manager.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.services.myPower;
in
{
  options.services.myPower = {
    enable = mkEnableOption "power management with suspend/hibernate and dimmer";

    idleDimSeconds = mkOption {
      type = types.int;
      default = 60;
      description = "Idle seconds before dimming display.";
    };

    idleLockSeconds = mkOption {
      type = types.int;
      default = 120;
      description = "Idle seconds before locking screen.";
    };

    idleSuspendSeconds = mkOption {
      type = types.int;
      default = 300;
      description = "Idle seconds before suspending.";
    };

    hibernateDelaySeconds = mkOption {
      type = types.int;
      default = 3600;
      description = "Seconds after suspend before hibernating (used by suspend-then-hibernate).";
    };

    enablePowerProfilesDaemon = mkOption {
      type = types.bool;
      default = true;
      description = "Enable power-profiles-daemon for power profile switching.";
    };
  };

  config = mkIf cfg.enable {
    # logind configuration: lid switch triggers suspend-then-hibernate
    services.logind = {
      settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "suspend-then-hibernate";
        HibernateDelaySec = "${toString cfg.hibernateDelaySeconds}s";
      };
    };

    # systemd sleep config
    systemd.sleep.settings.Sleep = {
      HibernateDelaySec = "${toString cfg.hibernateDelaySeconds}s";
    };

    # power profiles daemon
    services.power-profiles-daemon.enable = cfg.enablePowerProfilesDaemon;

    # Packages needed for idle management and brightness control
    environment.systemPackages = with pkgs; [ swayidle brightnessctl swaylock ];

    # swayidle user service – compatible with niri (wlroots-based)
    systemd.user.services.swayidle = {
      description = "Idle manager for Wayland (suspend/hibernate)";
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        ExecStart = ''
          ${pkgs.swayidle}/bin/swayidle -w \
            timeout ${toString cfg.idleDimSeconds} '${pkgs.brightnessctl}/bin/brightnessctl set 10%' \
            timeout ${toString cfg.idleLockSeconds} '${pkgs.swaylock}/bin/swaylock -f' \
            timeout ${toString cfg.idleSuspendSeconds} '${pkgs.systemd}/bin/systemctl suspend' \
            resume '${pkgs.brightnessctl}/bin/brightnessctl set 100%' \
            before-sleep '${pkgs.brightnessctl}/bin/brightnessctl set 100%' \
            after-resume '${pkgs.brightnessctl}/bin/brightnessctl set 100%'
        '';
        Environment = "PATH=${lib.makeBinPath [ pkgs.bash pkgs.brightnessctl pkgs.swaylock pkgs.systemd ]}";
      };
      wantedBy = [ "graphical-session.target" ];
    };

    # Ensure user is in video group for brightnessctl
    users.groups.video.members = [ "krozzzis" ];
  };
}
