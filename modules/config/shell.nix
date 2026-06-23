{ delib, lib, ... }:

delib.module {
  name = "shell";

  options = { myconfig, ... }: {
    shell.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable shell utilities (fish, eza, yazi, vim, etc.)";
    };
    shell.name = lib.mkOption {
      type = lib.types.enum [ "zsh" "fish" ];
      default = "zsh";
      description = "Which shell to use as the user's login shell";
    };
  };

  myconfig.ifEnabled = { ... }: {
    programs.shell.starship.enable = true;
  };

  home.ifEnabled = {
    home.sessionPath = [ "$HOME/.cargo/bin" ];
  };
}
