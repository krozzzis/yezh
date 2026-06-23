{ delib, lib, ... }:
delib.module {
  name = "programs.shell.htop";

  options = { myconfig, ... }: {
    programs.shell.htop.enable = lib.mkOption {
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
