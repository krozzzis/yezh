{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.bat";

  options = { myconfig, ... }: {
    shell.bat.enable = delib.boolOption myconfig.shell.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      bat
    ];
  };
}
