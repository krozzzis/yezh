{ delib, pkgs, ... }:

delib.module {
  name = "yezh.system.sudoRs";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    security.sudo-rs.enable = true;
  };
}
