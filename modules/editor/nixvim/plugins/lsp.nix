{ delib, pkgs, ... }:
delib.module {
  name = "editor.nixvim";

  home.ifEnabled = {
    programs.nixvim = {
      plugins.lsp = {
        enable = true;

        servers = {
          rust_analyzer = {
            enable = true;

            installCargo = false;
            installRustc = false;

            settings = {
              check.command = "clippy";
              checkOnSave = true;
            };
          };

          basedpyright = {
            enable = true;
          };

          ruff = {
            enable = true;
          };

          nixd = {
            enable = true;
          };

          taplo = {
            enable = true;
          };

          lua_ls = {
            enable = true;
          };

          jsonnet_ls = {
            enable = false;
          };
        };

        keymaps = {
          silent = true;

          lspBuf = {
            gd = {
              action = "definition";
              desc = "Go to definition";
            };
            gD = {
              action = "declaration";
              desc = "Go to declaration";
            };
            gr = {
              action = "references";
              desc = "References";
            };
            gi = {
              action = "implementation";
              desc = "Go to implementation";
            };
            K = {
              action = "hover";
              desc = "Hover documentation";
            };
            "<leader>ca" = {
              action = "code_action";
              desc = "Code action";
            };
            "<leader>rn" = {
              action = "rename";
              desc = "Rename symbol";
            };
          };
        };
      };

      extraPackages = with pkgs; [
        rust-analyzer
        rustc
        cargo
        basedpyright
        ruff
        nixd
        taplo
        lua-language-server
      ];
    };
  };
}
