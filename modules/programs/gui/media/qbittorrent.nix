{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.media.qbittorrent";

  options = { myconfig, ... }: {
    programs.gui.media.qbittorrent.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.media.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
