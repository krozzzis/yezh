{ delib, lib, ... }:
delib.module {
  name = "shell.htop";

  options = { myconfig, ... }: {
    shell.htop.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  home.ifEnabled = {
    programs.htop = {
      enable = true;
    };
  };
}
