{ delib, pkgs, ... }:
delib.module {
  name = "osa.dev.lsp.ruff";

  options = delib.singleEnableOption false;

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
