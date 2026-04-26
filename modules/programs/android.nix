{ delib, pkgs, ... }:
delib.module {
  name = "programs.android";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
        android-tools
        scrcpy
      ];
  };

  home.ifEnabled = {
    xdg.desktopEntries.scrcpy = {
        name = "Scrcpy";
        comment = "Android screen mirroring";
        exec = "scrcpy --always-on-top";
        icon = "scrcpy";
        terminal = false;
        categories = [ "Utility" ];
      };
  };
}
