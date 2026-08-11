{ delib, pkgs, ... }:
delib.module {
  name = "user.dev";

  myconfig.ifEnabled = {
    user.dev.lsp."taplo" = {
      enable = true;
      package = pkgs.taplo;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.taplo ];
  };
}
