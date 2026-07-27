{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.shell.fish";

  options = { myconfig, ... }: {
    yezh.shell.fish.enable = delib.boolOption (myconfig.user.shell.enable && myconfig.user.shell.default != null
        && lib.getName myconfig.yezh.shell.fish.pkg == lib.getName myconfig.user.shell.default.pkg);
    yezh.shell.fish.pkg = delib.packageOption pkgs.fish;
  };

  home.ifEnabled = { myconfig, ... }: {
    programs.fish = {
      enable = true;
      generateCompletions = true;

      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    programs.fzf.enableFishIntegration = myconfig.yezh.shell.fzf.enable;
  };

  nixos.ifEnabled = { myconfig, ... }: let
    inherit (myconfig.user.constants) username;
  in {
    programs.fish.enable = true;
  };
}

