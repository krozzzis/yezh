{ delib, pkgs, ... }:
delib.module {
  name = "user.dev";

  myconfig.ifEnabled = {
    user.dev.mcp."nixos" = {
      enable = true;
      type = "local";
      command = [ "mcp-nixos" ];
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.mcp-nixos ];
  };
}
