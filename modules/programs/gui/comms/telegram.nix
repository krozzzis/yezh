{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.comms.telegram";

  options = { myconfig, ... }: {
    programs.gui.comms.telegram.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.comms.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      telegram-desktop
    ];
  };
}
