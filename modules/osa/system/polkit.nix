{ delib, pkgs, lib, ... }:
delib.module {
  name = "osa.system.polkit";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = { myconfig, ... }: {
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

    # DMS (dank-material-shell) ships its own polkit auth UI baked into the
    # shell process, so starting the plain GNOME agent alongside it just
    # races two agents for the same D-Bus name and shows the uglier one.
    systemd.user.services.polkit-gnome-authentication-agent-1 = lib.mkIf (!(myconfig.osa.de.dms.enable or false)) {
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
