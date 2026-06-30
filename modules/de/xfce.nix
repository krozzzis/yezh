{ delib, pkgs, ... }:
delib.module {
  name = "de.xfce";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services.xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };
  };
}
