{ delib, pkgs, ... }:
delib.module {
  name = "osa.apps.polkitLxqtAgent";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      lxqt.lxqt-policykit
    ];
  };
}
