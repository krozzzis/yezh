{ delib, pkgs, ... }:
delib.module {
  name = "user.dev";

  myconfig.ifEnabled = {
    user.dev.lsp."nixd" = {
      enable = true;
      package = pkgs.nixd;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.nixd ];
  };
}
