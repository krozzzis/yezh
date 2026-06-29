{ delib, pkgs, ... }:
delib.module {
  name = "dev";

  myconfig.ifEnabled = {
    dev.lsp."basedpyright" = {
      enable = true;
      package = pkgs.basedpyright;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.basedpyright ];
  };
}
