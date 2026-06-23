{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.shell.usbutils";

  options = { myconfig, ... }: {
    programs.shell.usbutils.enable = lib.mkOption {
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
