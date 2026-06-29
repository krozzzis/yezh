{ delib, pkgs, ... }:
delib.module {
  name = "dev";

  myconfig.ifEnabled = {
    dev.lsp."taplo" = {
      enable = true;
      package = pkgs.taplo;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.taplo ];
  };
}
