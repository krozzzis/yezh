{ delib, lib, pkgs, ... }:
delib.module {
  name = "de.hyprland";

  options = { myconfig, ... }: {
    de.hyprland.enable = delib.boolOption false;
    de.hyprland.launcher.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = pkgs.walker; };
    };
  };

  nixos.ifEnabled = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };
}
