{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.shell.fish";

  options = { myconfig, ... }: {
    programs.shell.fish.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  home.ifEnabled = {
    programs.fish = {
      enable = true;
      generateCompletions = true;

      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    # adds to $PATH
    home.sessionPath = [
      "$HOME/.cargo/bin"
    ];
  };

  nixos.ifEnabled = { myconfig, ...}:
  let
    inherit (myconfig.constants) username;
  in
  {
    programs.fish = {
      enable = true;
    };

    users.users.${username}.shell = pkgs.fish;
  };
}
