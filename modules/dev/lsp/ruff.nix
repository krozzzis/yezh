{ delib, pkgs, ... }:
delib.module {
  name = "dev";

  myconfig.ifEnabled = {
    dev.lsp."ruff" = {
      enable = true;
      package = pkgs.ruff;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.ruff ];
  };
}
