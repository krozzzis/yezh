{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.qbittorrent";

  options = { myconfig, ... }: {
    media.qbittorrent.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
