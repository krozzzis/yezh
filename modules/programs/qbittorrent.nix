{ delib, pkgs, ... }:
delib.module {
  name = "programs.qbittorrent";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
