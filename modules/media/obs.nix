{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.obs";

  options = { myconfig, ... }: {
    media.obs.enable = delib.boolOption myconfig.gui.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      obs-studio
    ];
  };
}
