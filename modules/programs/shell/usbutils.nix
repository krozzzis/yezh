{ delib, pkgs, ... }:
delib.module {
  name = "programs.usbutils";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      usbutils
      openocd
    ];
  };
}
