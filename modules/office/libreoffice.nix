{ delib, lib, pkgs, ... }:
delib.module {
  name = "office.libreoffice";

  options = { myconfig, ... }: {
    office.libreoffice.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      libreoffice-qt-fresh
      hyphenDicts.ru-ru
      hyphenDicts.en-us
    ];
  };
}
