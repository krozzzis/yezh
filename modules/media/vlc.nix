{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.vlc";

  options = { myconfig, ... }: {
    media.vlc.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
    media.vlc.pkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.vlc;
    };
  };

  nixos.ifEnabled = { myconfig, ... }: {
    environment.systemPackages = [
      myconfig.media.vlc.pkg
    ];
  };
}
