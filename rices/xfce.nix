{ delib, ... }:
delib.rice {
  name = "xfce";

  myconfig = {
    yezh.de.xfce.enable = true;
  };

  nixos = {
    services.displayManager.defaultSession = "xfce";
  };
}
