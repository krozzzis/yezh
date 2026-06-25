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
    ];

    # programs.opencode = {
    #   enable = true;
    #   enableMcpIntegration = true;  # подтянет из programs.mcp.servers
    # };

    # или вручную в settings
    # programs.opencode.settings = {
    #   mcp.nixos = {
    #     type = "local";
    #     command = "mcp-nixos";
    #     enabled = true;
    #   };
    # };

    # xdg.configFile."opencode/opencode.json".text = lib.generators.toJSON {
    #   # "$schema" = "https://opencode.ai/config.json";
    #   mcp = {
    #     gh_grep = {
    #       type = "remote";
    #       url = "https://mcp.grep.app";
    #     };
    #     context7 = {
    #       type = "remote";
    #       url = "https://mcp.context7.com/mcp";
    #     };
    #     exa = {
    #       type = "remote";
    #       url = "https://mcp.exa.ai/mcp";
    #     };
    #   };
    #   # permission = {
    #   #   websearch = "allow";
    #   #   grep = "allow";
    #   #   glob = "allow";
    #   # };
    # };
  };
}
