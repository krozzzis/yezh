{ delib, pkgs, ... }:

delib.module {
  name = "shell.sudo-rs";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    security.sudo-rs.enable = true;
  };
}
