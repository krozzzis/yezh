{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.media.reaper";

  options = { myconfig, ... }: {
    programs.gui.media.reaper.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.media.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      reaper
    ];
  };
}
