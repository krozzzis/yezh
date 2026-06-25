{ delib, lib, pkgs, ... }:
delib.module {
  name = "comms.telegram";

  options = { myconfig, ... }: {
    comms.telegram.enable = lib.mkOption {
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
