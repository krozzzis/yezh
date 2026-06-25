{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.reaper";

  options = { myconfig, ... }: {
    media.reaper.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      reaper
    ];
  };
}
