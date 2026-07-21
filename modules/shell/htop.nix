{ delib, lib, ... }:
delib.module {
  name = "shell.htop";

  options = { myconfig, ... }: {
    shell.htop.enable = delib.boolOption myconfig.shell.enable;
  };

  home.ifEnabled = {
    programs.htop = {
      enable = true;
    };
  };
}
