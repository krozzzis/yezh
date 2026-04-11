{ delib, pkgs, ... }:
delib.module {
  name = "programs.kdeconnect";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    programs.kdeconnect.enable = true;

    networking.firewall = {
        enable = true;
        allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
        allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
      };
  };
}
