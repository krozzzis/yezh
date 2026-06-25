{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.android";

  options = { myconfig, ... }: {
    apps.android = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = myconfig.gui.enable;
      };
      tools = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Android tools (adb, fastboot)";
      };
      screencast = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Android screen mirroring (scrcpy)";
      };
    };
  };

  nixos.ifEnabled = { cfg, ... }:
  let
    packages = with pkgs; (
      (lib.optionals cfg.tools [ android-tools ])
      ++ (lib.optionals cfg.screencast [ scrcpy ])
    );
  in {
    environment.systemPackages = packages;
  };

  home.ifEnabled = { cfg, ... }: lib.mkIf cfg.screencast {
    xdg.desktopEntries.scrcpy = {
        name = "Scrcpy";
        comment = "Android screen mirroring";
        exec = "scrcpy --always-on-top";
        icon = "scrcpy";
        terminal = false;
        categories = [ "Utility" ];
      };
  };
}
