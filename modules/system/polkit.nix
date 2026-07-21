{ delib, pkgs, ... }:
delib.module {
  name = "system.polkit";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    security.polkit.enable = true;
    security.polkit.enablePkexecWrapper = true;

    security.polkit.extraConfig = ''
      polkit.addRule(function (action, subject) {
        if (
          subject.isInGroup("users") &&
          [
            "org.freedesktop.login1.reboot",
            "org.freedesktop.login1.reboot-multiple-sessions",
            "org.freedesktop.login1.power-off",
            "org.freedesktop.login1.power-off-multiple-sessions",
          ].indexOf(action.id) !== -1
        ) {
          return polkit.Result.YES;
        }
      });
    '';

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "PolicyKit Authentication Agent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
