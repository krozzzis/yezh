{ delib, pkgs, ... }:
delib.module {
  name = "programs.pciutils";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      pciutils
    ];
  };
}
