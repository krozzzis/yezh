{ delib, ... }:
delib.module {
  name = "osa.dev.mcp.websearch";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    user.dev.mcp."websearch" = {
      enable = true;
      type = "remote";
      url = "https://mcp.exa.ai/mcp";
    };
  };
}
