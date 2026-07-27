{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.apps.telegram";

  options = { myconfig, ... }: {
    yezh.apps.telegram.enable = delib.boolOption myconfig.user.gui.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      telegram-desktop
    ];
  };
}
