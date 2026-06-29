{ delib, pkgs, ... }:
delib.module {
  name = "dev";

  myconfig.ifEnabled = {
    dev.mcp."nixos" = {
      enable = true;
      type = "local";
      command = [ "mcp-nixos" ];
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.mcp-nixos ];
  };
}
