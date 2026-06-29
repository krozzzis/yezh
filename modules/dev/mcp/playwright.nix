{ delib, pkgs, ... }:
delib.module {
  name = "dev";

  myconfig.ifEnabled = {
    dev.mcp."playwright" = {
      enable = true;
      type = "local";
      command = [ "playwright-mcp" ];
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.playwright-mcp ];
  };
}
