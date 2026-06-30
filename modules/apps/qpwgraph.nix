{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.qpwgraph";

  options = { myconfig, ... }: {
    apps.qpwgraph.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
    apps.qpwgraph.pkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.qpwgraph;
    };
  };

  home.ifEnabled = { cfg, ... }: {
    home.packages = [ cfg.pkg ];
  };
}
