{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.usbutils";

  options = { myconfig, ... }: {
    shell.usbutils.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      usbutils
      openocd
    ];
  };
}
