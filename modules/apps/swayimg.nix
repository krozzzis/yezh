{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.swayimg";

  options = { myconfig, ... }: {
    apps.swayimg.enable = delib.boolOption myconfig.gui.enable;
    apps.swayimg.pkg = delib.packageOption pkgs.swayimg;
  };

  home.ifEnabled = { cfg, ... }: {
    home.packages = [ cfg.pkg ];
  };
}
