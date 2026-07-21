{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.fish";

  options = { myconfig, ... }: {
    shell.fish.enable = delib.boolOption (myconfig.shell.enable && myconfig.shell.default != null
        && lib.getName myconfig.shell.fish.pkg == lib.getName myconfig.shell.default.pkg);
    shell.fish.pkg = delib.packageOption pkgs.fish;
  };

  home.ifEnabled = { myconfig, ... }: {
    programs.fish = {
      enable = true;
      generateCompletions = true;

      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    programs.fzf.enableFishIntegration = myconfig.shell.fzf.enable;
  };

  nixos.ifEnabled = { myconfig, ... }: let
    inherit (myconfig.constants) username;
  in {
    programs.fish.enable = true;
  };
}

