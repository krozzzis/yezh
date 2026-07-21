{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.audacity";

  options = { myconfig, ... }: {
    media.audacity.enable = delib.boolOption myconfig.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
