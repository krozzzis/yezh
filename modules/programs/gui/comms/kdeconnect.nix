{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.comms.kdeconnect";

  options = { myconfig, ... }: {
    programs.gui.comms.kdeconnect.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.comms.enable;
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
