{ delib, pkgs, ... }:
delib.module {
  name = "system.polkit-lxqt-agent";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      lxqt.lxqt-policykit
    ];
  };
}
