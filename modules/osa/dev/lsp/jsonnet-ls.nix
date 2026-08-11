{ delib, pkgs, ... }:
delib.module {
  name = "user.dev";

  myconfig.ifEnabled = {
    user.dev.lsp."jsonnet-ls" = {
      enable = false;
      package = null;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ ];
  };
}
