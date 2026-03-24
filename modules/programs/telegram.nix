{ delib, pkgs, ... }:
delib.module {
  name = "programs.telegram";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      telegram-desktop
    ];
  };
}
