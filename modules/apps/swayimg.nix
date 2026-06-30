{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.swayimg";

  options = { myconfig, ... }: {
    apps.swayimg.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
    apps.swayimg.pkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.swayimg;
    };
  };

  home.ifEnabled = { cfg, ... }: {
    home.packages = [ cfg.pkg ];
  };
}
