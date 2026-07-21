{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.arduinoIde";

  options = { myconfig, ... }: {
    apps.arduinoIde.enable = delib.boolOption myconfig.gui.enable;
    apps.arduinoIde.pkg = delib.packageOption (pkgs.arduino-ide);
  };

  home.ifEnabled = { cfg, ... }: {
    home.packages = [ cfg.pkg pkgs.python3 ];
  };

  nixos.ifEnabled = { myconfig, ... }: {
    users.users.${myconfig.constants.username}.extraGroups = [ "dialout" ];
  };
}
