{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.media.qbittorrent";

  options = { myconfig, ... }: {
    yezh.media.qbittorrent.enable = delib.boolOption myconfig.user.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
