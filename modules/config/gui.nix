{ delib, lib, pkgs, ... }:

delib.module {
  name = "gui";

  options = { myconfig, ... }: {
    gui.enable = delib.description (delib.boolOption false) "Enable GUI mode";
    gui.fonts.nerdfonts = delib.description (delib.boolOption false) "Enable Nerd Fonts for icons in terminal and GUI";
  };

}
