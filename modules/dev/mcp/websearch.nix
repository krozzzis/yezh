{ delib, pkgs, ... }:
delib.module {
  name = "dev";

  myconfig.ifEnabled = {
    dev.mcp."websearch" = {
      enable = true;
      type = "remote";
      url = "https://mcp.exa.ai/mcp";
    };
  };

  home.ifEnabled = {
    home.packages = [ ];
  };
}
