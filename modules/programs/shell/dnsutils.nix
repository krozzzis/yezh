{ delib, pkgs, ... }:
delib.module {
  name = "programs.dnsutils";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      dnsutils
    ];
  };
}
