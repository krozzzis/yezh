{ delib, pkgs, ... }:
delib.module {
  name = "user.dev";

  myconfig.ifEnabled = {
    user.dev.mcp."websearch" = {
      enable = true;
      type = "remote";
      url = "https://mcp.exa.ai/mcp";
    };
  };

  home.ifEnabled = {
    home.packages = [ ];
  };
}
