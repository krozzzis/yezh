{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.fish";

  options = { myconfig, ... }: {
    shell.fish.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable && myconfig.shell.default != null
        && lib.getName myconfig.shell.fish.pkg == lib.getName myconfig.shell.default.pkg;
    };
    shell.fish.pkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.fish;
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

  nixos.ifEnabled = { myconfig, ... }: let
    inherit (myconfig.constants) username;
  in {
    programs.fish.enable = true;
  };
}

