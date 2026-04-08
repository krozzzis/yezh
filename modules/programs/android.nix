{ delib, pkgs, ... }:
delib.module {
  name = "programs.android";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.udev.packages = with pkgs; [
        android-tools
      ];
  };
}
