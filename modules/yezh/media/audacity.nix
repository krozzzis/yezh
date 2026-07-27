{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.media.audacity";

  options = { myconfig, ... }: {
    yezh.media.audacity.enable = delib.boolOption myconfig.user.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
