{ delib, pkgs, ... }:

delib.module {
  name = "system.sudo-rs";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    security.sudo-rs.enable = true;
  };
}
