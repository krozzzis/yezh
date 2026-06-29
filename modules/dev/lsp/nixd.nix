{ delib, pkgs, ... }:
delib.module {
  name = "dev";

  myconfig.ifEnabled = {
    dev.lsp."nixd" = {
      enable = true;
      package = pkgs.nixd;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.nixd ];
  };
}
