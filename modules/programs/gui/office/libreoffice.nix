{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.office.libreoffice";

  options = { myconfig, ... }: {
    programs.gui.office.libreoffice.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.office.enable;
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
