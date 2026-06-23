{ delib, lib, ... }:
delib.module {
  name = "programs.shell.ripgrep";

  options = { myconfig, ... }: {
    programs.shell.ripgrep.enable = lib.mkOption {
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
