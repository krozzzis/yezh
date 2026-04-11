{ delib, pkgs, ... }:
delib.module {
  name = "programs.android";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
        android-tools
        scrcpy
      ];
  };
}
