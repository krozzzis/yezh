{ delib, pkgs, ... }:
delib.module {
  name = "user.dev";

  myconfig.ifEnabled = {
    user.dev.lsp."basedpyright" = {
      enable = true;
      package = pkgs.basedpyright;
      settings = { };
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.basedpyright ];
  };
}
