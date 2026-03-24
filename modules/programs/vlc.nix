{ delib, pkgs, ... }:
delib.module {
  name = "programs.vlc";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      vlc
    ];
  };
}
