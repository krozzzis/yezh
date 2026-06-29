{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.telegram";

  options = { myconfig, ... }: {
    apps.telegram.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      telegram-desktop
    ];
  };
}
