{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.ghCli";

  options = { myconfig, ... }: {
    shell.ghCli.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
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
