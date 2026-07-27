{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.apps.arduinoIde";

  options = { myconfig, ... }: {
    yezh.apps.arduinoIde.enable = delib.boolOption myconfig.user.gui.enable;
    yezh.apps.arduinoIde.pkg = delib.packageOption (pkgs.arduino-ide);
  };

  home.ifEnabled = { cfg, ... }: {
    home.packages = [ cfg.pkg pkgs.python3 ];
  };

  nixos.ifEnabled = { myconfig, ... }: {
    users.users.${myconfig.user.constants.username}.extraGroups = [ "dialout" ];
  };
}
