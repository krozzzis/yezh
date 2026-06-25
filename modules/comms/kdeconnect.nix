{ delib, lib, pkgs, ... }:
delib.module {
  name = "comms.kdeconnect";

  options = { myconfig, ... }: {
    comms.kdeconnect.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
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
