{ delib, ... }:
delib.rice {
  name = "hyprland";

  myconfig = {
    programs.hyprland.enable = true;
    system.polkit-lxqt-agent.enable = true;
    system.sddm.enable = true;
  };

  nixos = {
    services.displayManager.defaultSession = "hyprland";
  };
}
