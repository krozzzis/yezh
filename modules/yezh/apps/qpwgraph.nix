{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.apps.qpwgraph";

  options = { myconfig, ... }: {
    yezh.apps.qpwgraph.enable = delib.boolOption myconfig.user.gui.enable;
    yezh.apps.qpwgraph.pkg = delib.packageOption pkgs.qpwgraph;
  };

  home.ifEnabled = { cfg, ... }: {
    home.packages = [ cfg.pkg ];
  };
}
