{ delib, pkgs, ... }:
delib.module {
  name = "user.dev";

  myconfig.ifEnabled = {
    user.dev.lsp."ruff" = {
      enable = true;
      package = pkgs.ruff;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.ruff ];
  };
}
