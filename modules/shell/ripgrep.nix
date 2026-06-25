{ delib, lib, ... }:
delib.module {
  name = "shell.ripgrep";

  options = { myconfig, ... }: {
    shell.ripgrep.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  home.ifEnabled = {
    programs.ripgrep = {
      enable = true;
    };
  };
}
