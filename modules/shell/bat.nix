{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.bat";

  options = { myconfig, ... }: {
    shell.bat.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      bat
    ];
  };
}
