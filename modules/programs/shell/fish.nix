{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.shell.fish";

  options = { myconfig, ... }: {
    programs.shell.fish.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.name == "fish";
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
  };

  nixos.ifEnabled = { myconfig, ... }:
  let
    inherit (myconfig.constants) username;
  in
  {
    programs.fish.enable = true;
  };

  nixos.always = { myconfig, ... }:
  let
    inherit (myconfig.constants) username;
  in
  {
    users.users.${username}.shell = lib.mkIf (myconfig.shell.name == "fish") pkgs.fish;
  };
}
