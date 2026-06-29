{ delib, lib, pkgs, ... }:

let
  lspServerSubmodule = lib.types.submodule {
    options = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable this LSP server";
      };
      package = lib.mkOption {
        type = lib.types.nullOr lib.types.package;
        default = null;
        description = "LSP server package";
      };
      settings = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = { };
        description = "LSP server settings";
      };
    };
  };

  mcpServerSubmodule = lib.types.submodule {
    options = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable this MCP server";
      };
      type = lib.mkOption {
        type = lib.types.enum [ "local" "remote" ];
        description = "MCP server type";
      };
      command = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        default = null;
        description = "Command for local MCP server";
      };
      url = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "URL for remote MCP server";
      };
    };
  };
in
delib.module {
  name = "dev";

  options = { myconfig, ... }: {
    dev.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable development tools (LSP, MCP, etc.)";
    };

    dev.lsp = lib.mkOption {
      type = lib.types.attrsOf lspServerSubmodule;
      default = { };
      description = "LSP server configurations";
    };

    dev.mcp = lib.mkOption {
      type = lib.types.attrsOf mcpServerSubmodule;
      default = { };
      description = "MCP server configurations";
    };
  };
}
