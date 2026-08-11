{ delib, pkgs, ... }:
delib.module {
  name = "user.dev";

  myconfig.ifEnabled = {
    user.dev.mcp."playwright" = {
      enable = true;
      type = "local";
      command = [ "playwright-mcp" ];
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.playwright-mcp ];
  };
}
