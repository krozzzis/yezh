{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.shell.ghCli";

  options = { myconfig, ... }: {
    yezh.shell.ghCli.enable = delib.boolOption myconfig.user.shell.enable;
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
