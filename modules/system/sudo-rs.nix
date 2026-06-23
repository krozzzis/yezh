{ delib, pkgs, ... }:

delib.module {
  name = "system.sudo-rs";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    security.sudo-rs.enable = true;
  };
}
