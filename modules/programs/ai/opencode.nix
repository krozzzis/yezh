{ delib, pkgs, lib, ... }:
delib.module {
  name = "programs.ai.opencode";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      opencode
    ];

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
