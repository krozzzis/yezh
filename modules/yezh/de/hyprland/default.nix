{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.de.hyprland";

  options = { myconfig, ... }: {
    yezh.de.hyprland.enable = delib.boolOption false;
    yezh.de.hyprland.launcher.default = lib.mkOption {
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
