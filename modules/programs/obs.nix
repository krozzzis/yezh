{ delib, pkgs, ... }:
delib.module {
  name = "programs.obs";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      obs-studio
    ];
  };
}
