{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.media.obs";

  options = { myconfig, ... }: {
    programs.gui.media.obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.media.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      obs-studio
    ];
  };
}
