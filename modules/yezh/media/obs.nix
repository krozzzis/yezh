{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.media.obs";

  options = { myconfig, ... }: {
    yezh.media.obs.enable = delib.boolOption myconfig.user.gui.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      obs-studio
    ];
  };
}
