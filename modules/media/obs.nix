{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.obs";

  options = { myconfig, ... }: {
    media.obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      obs-studio
    ];
  };
}
