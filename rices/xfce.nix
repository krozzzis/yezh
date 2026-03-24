{ delib, ... }:
delib.rice {
  name = "xfce";

  myconfig = {
    programs.xfce.enable = true;
  };

  nixos = {
    services.displayManager.defaultSession = "xfce";
  };
}
