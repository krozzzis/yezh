{ delib, pkgs, lib, ... }:
delib.module {
  name = "ai.opencode";

  options = { myconfig, ... }: {
    ai.opencode.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      opencode
      mcp-nixos
      playwright-mcp
    ];

    xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
      mcp = {
        nixos = {
          type = "local";
          command = ["mcp-nixos"];
        };
        websearch = {
          type = "remote";
          url = "https://mcp.exa.ai/mcp";
        };
        playwright = {
          type = "local";
          command = ["playwright-mcp"];
        };
      };
      permission = {
        websearch = "allow";
        webfetch = "allow";
        grep = "allow";
        glob = "allow";
      };
    };
  };
}
