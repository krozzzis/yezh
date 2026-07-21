{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.ghCli";

  options = { myconfig, ... }: {
    shell.ghCli.enable = delib.boolOption myconfig.shell.enable;
  };

  home.ifEnabled = {
    programs.gh = {
      enable = true;

      gitCredentialHelper = {
        enable = true;
      };
    };
  };
}
