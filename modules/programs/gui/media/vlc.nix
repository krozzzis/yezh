{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.media.vlc";

  options = { myconfig, ... }: {
    programs.gui.media.vlc.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.media.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      vlc
    ];
  };
}
