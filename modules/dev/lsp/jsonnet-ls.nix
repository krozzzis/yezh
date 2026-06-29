{ delib, pkgs, ... }:
delib.module {
  name = "dev";

  myconfig.ifEnabled = {
    dev.lsp."jsonnet-ls" = {
      enable = false;
      package = null;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ ];
  };
}
