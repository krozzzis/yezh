{ delib, ... }:
delib.rice {
  name = "hyprland";

  myconfig = {
    de.hyprland.enable = true;
    apps.polkitLxqtAgent.enable = true;
    system.sddm.enable = true;
  };

  nixos = {
    services.displayManager.defaultSession = "hyprland";
  };
}
