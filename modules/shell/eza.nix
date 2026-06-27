{ delib, lib, ... }:
delib.module {
  # ls replacement
  name = "shell.eza";

  options = { myconfig, ... }: {
    shell.eza.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  home.ifEnabled = {
    programs.eza = {
      enable = true;
    };

    home = {
      shellAliases = {
        l = "eza --icons --no-permissions --no-user";
        ls = "eza --icons";
        la = "eza -la --icons";
        ll = "eza -l --icons";
        lt = "eza -l --tree";
      };
    };
  };
}
