{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.apps.swayimg";

  options = { myconfig, ... }: {
    yezh.apps.swayimg.enable = delib.boolOption myconfig.user.gui.enable;
    yezh.apps.swayimg.pkg = delib.packageOption pkgs.swayimg;
  };

  home.ifEnabled = { cfg, ... }: {
    home.packages = [ cfg.pkg ];
  };
}
