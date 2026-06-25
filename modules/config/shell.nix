{ delib, lib, ... }:

delib.module {
  name = "shell";

  options = { myconfig, ... }: {
    shell.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable shell utilities (fish, eza, yazi, vim, etc.)";
    };
    shell.default = lib.mkOption {
      type = lib.types.nullOr (lib.types.attrs);
      default = null;
      description = "Default shell module (set to myconfig.shell.zsh or myconfig.shell.fish in host)";
    };
  };

  home.ifEnabled = {
    home.sessionPath = [ "$HOME/.cargo/bin" ];
  };

  nixos.always = { myconfig, ... }: let
    inherit (myconfig.constants) username;
  in {
    users.users.${username}.shell = lib.mkIf (myconfig.shell.default != null)
      myconfig.shell.default.pkg;
  };
}
