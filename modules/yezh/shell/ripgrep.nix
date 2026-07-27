{ delib, lib, ... }:
delib.module {
  name = "yezh.shell.ripgrep";

  options = { myconfig, ... }: {
    yezh.shell.ripgrep.enable = delib.boolOption myconfig.user.shell.enable;
  };

  home.ifEnabled = {
    programs.ripgrep = {
      enable = true;
    };
  };
}
