{ delib, lib, pkgs, ... }:
delib.module {
  name = "osa.ai.opencode";

  options = { myconfig, ... }: {
    osa.ai.opencode.enable = delib.boolOption myconfig.user.gui.enable;
  };

  home.ifEnabled = { myconfig, ... }:
    let
      enabledServers = lib.filterAttrs (_name: srv: srv.enable) myconfig.user.dev.mcp;

      mkMcpServer = name: server: {
        type = server.type;
      } // lib.optionalAttrs (server.command != null) {
        command = server.command;
      } // lib.optionalAttrs (server.url != null) {
        url = server.url;
      };

      mcpServers = builtins.listToAttrs (map (name: {
        inherit name;
        value = mkMcpServer name myconfig.user.dev.mcp.${name};
      }) (builtins.attrNames enabledServers));
    in
    {
      home.packages = with pkgs; [
        opencode
      ];

      xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
        mcp = mcpServers;
        permission = {
          websearch = "allow";
          webfetch = "allow";
          grep = "allow";
          glob = "allow";
        };
      };
    };
}
