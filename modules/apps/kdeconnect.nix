{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.kdeconnect";

  options = { myconfig, ... }: {
    apps.kdeconnect.enable = delib.boolOption myconfig.gui.enable;
  };

  nixos.ifEnabled = {
    programs.kdeconnect.enable = true;

    networking.firewall = {
        enable = true;
        allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
        allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
      };
  };
}
