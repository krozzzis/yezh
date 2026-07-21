{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.qbittorrent";

  options = { myconfig, ... }: {
    media.qbittorrent.enable = delib.boolOption myconfig.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
