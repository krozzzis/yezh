{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.vlc";

  options = { myconfig, ... }: {
    media.vlc.enable = delib.boolOption myconfig.gui.enable;
    media.vlc.pkg = delib.packageOption pkgs.vlc;
  };

  nixos.ifEnabled = { myconfig, ... }: {
    environment.systemPackages = [
      myconfig.media.vlc.pkg
    ];
  };
}
