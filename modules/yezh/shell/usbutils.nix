{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.shell.usbutils";

  options = { myconfig, ... }: {
    yezh.shell.usbutils.enable = delib.boolOption myconfig.user.shell.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      usbutils
      openocd
    ];
  };
}
