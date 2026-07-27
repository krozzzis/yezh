{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.media.vlc";

  options = { myconfig, ... }: {
    yezh.media.vlc.enable = delib.boolOption myconfig.user.gui.enable;
    yezh.media.vlc.pkg = delib.packageOption pkgs.vlc;
  };

  nixos.ifEnabled = { myconfig, ... }: {
    environment.systemPackages = [
      myconfig.yezh.media.vlc.pkg
    ];
  };
}
