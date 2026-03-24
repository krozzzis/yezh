{ delib, pkgs, ... }:
delib.module {
  name = "programs.fish";

  options = delib.singleEnableOption true;

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
