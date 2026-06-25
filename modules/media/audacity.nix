{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.audacity";

  options = { myconfig, ... }: {
    media.audacity.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
