{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.qpwgraph";

  options = { myconfig, ... }: {
    apps.qpwgraph.enable = delib.boolOption myconfig.gui.enable;
    apps.qpwgraph.pkg = delib.packageOption pkgs.qpwgraph;
  };

  home.ifEnabled = { cfg, ... }: {
    home.packages = [ cfg.pkg ];
  };
}
