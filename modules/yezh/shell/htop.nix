{ delib, lib, ... }:
delib.module {
  name = "yezh.shell.htop";

  options = { myconfig, ... }: {
    yezh.shell.htop.enable = delib.boolOption myconfig.user.shell.enable;
  };

  home.ifEnabled = {
    programs.htop = {
      enable = true;
    };
  };
}
