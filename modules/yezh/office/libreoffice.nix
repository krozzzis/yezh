{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.office.libreoffice";

  options = { myconfig, ... }: {
    yezh.office.libreoffice.enable = delib.boolOption myconfig.user.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      libreoffice-qt-fresh
      hyphenDicts.ru-ru
      hyphenDicts.en-us
    ];
  };
}
