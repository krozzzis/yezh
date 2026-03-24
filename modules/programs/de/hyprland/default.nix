{ delib, pkgs, ... }:
delib.module {
  name = "programs.hyprland";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };
}
