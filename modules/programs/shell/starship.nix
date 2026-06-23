{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.shell.starship";

  options = { myconfig, ... }: {
    programs.shell.starship.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  nixos.ifEnabled = { myconfig, ...}:
    programs.starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;
      };
    };
}
