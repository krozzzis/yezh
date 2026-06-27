{ delib, lib, pkgs, ... }:
delib.module {
  name = "dev.zed";

  options = { myconfig, ... }: {
    dev.zed.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      nixd
      rust-analyzer
      basedpyright
      ruff
      taplo
      nixfmt
    ];

    programs.zed-editor = {
      enable = true;

      extensions = [
        "nix"
        "rust"
        "python"
        "toml"
      ];

      extraPackages = with pkgs; [
        rust-analyzer
        basedpyright
        ruff
        nixd
        nixfmt
        taplo
      ];

      userSettings = {
        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        title_bar = {
          show_sign_in = false;
          show_branch_icon = false;
        };

        lsp = {
          rust-analyzer = {
            check_on_save = true;
            check.command = "clippy";
          };
          basedpyright = { };
          ruff = {
            format = "on";
            lint = "on";
          };
          nixd = { };
          taplo = { };
        };

        languages = {
          Rust = {
            language_servers = [ "rust-analyzer" ];
            formatter.external.command = "rustfmt";
          };
          Python = {
            language_servers = [ "basedpyright" "ruff" ];
            formatter.external = {
              command = "ruff";
              arguments = [ "format" ];
            };
          };
          Nix = {
            language_servers = [ "nixd" ];
            formatter.external = {
              command = "nixfmt";
            };
          };
          TOML = {
            language_servers = [ "taplo" ];
          };
        };
      };
    };
  };
}
