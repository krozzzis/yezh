{ delib, pkgs, ... }:
delib.module {
  name = "programs.nautilus";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      nautilus
    ];
  };
}
