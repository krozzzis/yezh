{ delib, ... }:
delib.rice {
  name = "xfce";

  myconfig = {
    de.xfce.enable = true;
  };

  nixos = {
    services.displayManager.defaultSession = "xfce";
  };
}
