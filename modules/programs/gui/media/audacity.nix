{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.media.audacity";

  options = { myconfig, ... }: {
    programs.gui.media.audacity.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.media.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
