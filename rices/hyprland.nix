{ delib, ... }:
delib.rice {
  name = "hyprland";

  myconfig = {
    yezh.de.hyprland.enable = true;
    yezh.apps.polkitLxqtAgent.enable = true;
    yezh.system.sddm.enable = true;
  };

  nixos = {
    services.displayManager.defaultSession = "hyprland";
  };
}
