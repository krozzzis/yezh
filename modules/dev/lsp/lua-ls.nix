{ delib, pkgs, ... }:
delib.module {
  name = "dev";

  myconfig.ifEnabled = {
    dev.lsp."lua-ls" = {
      enable = true;
      package = pkgs.lua-language-server;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.lua-language-server ];
  };
}
