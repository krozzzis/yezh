{ delib, lib, ... }:
delib.module {
  name = "shell.ripgrep";

  options = { myconfig, ... }: {
    shell.ripgrep.enable = delib.boolOption myconfig.shell.enable;
  };

  home.ifEnabled = {
    programs.ripgrep = {
      enable = true;
    };
  };
}
