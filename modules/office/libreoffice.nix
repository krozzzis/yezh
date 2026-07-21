{ delib, lib, pkgs, ... }:
delib.module {
  name = "office.libreoffice";

  options = { myconfig, ... }: {
    office.libreoffice.enable = delib.boolOption myconfig.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      libreoffice-qt-fresh
      hyphenDicts.ru-ru
      hyphenDicts.en-us
    ];
  };
}
