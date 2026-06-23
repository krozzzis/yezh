{ delib, pkgs, ... }:
delib.module {
  name = "programs.gui.de.xfce";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    nixpkgs.config.pulseaudio = true;

    services.xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };
  };
}
