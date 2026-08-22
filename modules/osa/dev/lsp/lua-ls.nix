{ delib, pkgs, ... }:
delib.module {
  name = "osa.dev.lsp.lua-ls";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    user.dev.lsp."lua-ls" = {
      enable = true;
      package = pkgs.lua-language-server;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.lua-language-server ];
  };
}
