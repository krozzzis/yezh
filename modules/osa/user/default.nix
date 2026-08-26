# The `user.*` interface contract.
#
# Pure option declarations -- no behavior, nothing is enabled here. Every
# consumer flake (osa-krozzzis/osa-user, your own config) sets these values;
# every `osa.*` module reads them via `myconfig.user.*`. A downstream flake
# that imports `${osa}/modules` MUST set at least:
#
#   user.constants.username
#   user.constants.useremail
#
# Everything else has a neutral default, so a headless server can ignore
# the whole gui/shell surface.
{ delib, lib, pkgs, ... }:
let
  # A "default app" handle: an attrset carrying at least `.pkg`, so callers
  # can do `app.pkg.meta.mainProgram or (lib.getName app.pkg)`.
  defaultAppType = lib.types.attrs;

  lspServerSubmodule = lib.types.submodule {
    options = {
      enable = delib.description (delib.boolOption true) "Enable this LSP server";
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
      enable = delib.description (delib.boolOption true) "Enable this MCP server";
      type = lib.mkOption {
        type = lib.types.enum [
          "local"
          "remote"
        ];
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
  name = "user";

  options = { myconfig, ... }: {
    user.gui.enable = delib.description (delib.boolOption false) "GUI mode: enables desktop-oriented osa modules by default";

    user.gui.fonts.nerdfonts = delib.description (delib.boolOption false) "Nerd Fonts for icons in terminal and GUI prompts";

    user.fonts.regular = lib.mkOption {
      type = lib.types.attrs;
      default = {
        pkg = pkgs.inter;
        name = "Inter";
      };
      description = "Regular (sans-serif) font for UI — used in GTK/Qt/Plymouth/etc.";
    };

    user.fonts.monospace = lib.mkOption {
      type = lib.types.attrs;
      default = {
        pkg = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
      description = "Monospace font for terminals/editors — used in wezterm, editors, etc.";
    };

    user.shell.enable = delib.description (delib.boolOption false) "Shell mode: enables CLI utility modules (eza, fzf, ripgrep, ...)";

    user.shell.default =
      delib.description
        (lib.mkOption {
          type = lib.types.nullOr lib.types.attrs;
          default = null;
        })
        "Default login shell as `{ pkg = <shell package>; }`; null leaves the system default. Set to e.g. `{ pkg = myconfig.osa.shell.fish.pkg; }`";

    user.constants.username = delib.description (lib.mkOption {
      type = lib.types.str;
    }) "Primary user's login name (required)";

    user.constants.useremail = delib.description (lib.mkOption {
      type = lib.types.str;
    }) "Primary user's email, used for git config (required)";

    user.editor.default =
      delib.description
        (lib.mkOption {
          type = defaultAppType;
          default = {
            pkg = myconfig.osa.editor.vim.pkg;
          };
        })
        "Default editor handle; consumers derive the binary via `.pkg.meta.mainProgram or (lib.getName .pkg)`";

    user.dev.lsp = lib.mkOption {
      type = lib.types.attrsOf lspServerSubmodule;
      default = { };
      description = "LSP servers exposed to editors and AI tools (populated by osa.dev.lsp.* modules)";
    };

    user.dev.mcp = lib.mkOption {
      type = lib.types.attrsOf mcpServerSubmodule;
      default = { };
      description = "MCP servers exposed to AI tools (populated by osa.dev.mcp.* modules)";
    };
  };
}
