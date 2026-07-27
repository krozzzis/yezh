{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.shell.bat";

  options = { myconfig, ... }: {
    yezh.shell.bat.enable = delib.boolOption myconfig.user.shell.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      bat
    ];
  };
}
