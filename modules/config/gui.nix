{ delib, lib, pkgs, ... }:

delib.module {
  name = "gui";

  options = { myconfig, ... }: {
    gui.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GUI mode";
    };
    gui.fonts.nerdfonts = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Nerd Fonts for icons in terminal and GUI";
    };
  };

}
