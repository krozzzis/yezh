{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.telegram";

  options = { myconfig, ... }: {
    apps.telegram.enable = delib.boolOption myconfig.gui.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      telegram-desktop
    ];
  };
}
