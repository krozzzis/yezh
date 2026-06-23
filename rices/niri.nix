{ delib, ... }:
delib.rice {
  name = "niri";

  myconfig = {
    programs.gui.de.niri.enable = true;
    programs.gui.de.dms.enable = true;
    programs.gui.apps.walker.enable = true;
  };

  nixos = {
    services.displayManager.defaultSession = "niri";
  };
}
