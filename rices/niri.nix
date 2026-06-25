{ delib, ... }:
delib.rice {
  name = "niri";

  myconfig = {
    de.niri.enable = true;
    de.dms.enable = true;
    apps.walker.enable = true;
  };

  nixos = {
    services.displayManager.defaultSession = "niri";
  };
}
