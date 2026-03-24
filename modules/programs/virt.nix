{ delib, pkgs, ... }:
delib.module {
  name = "programs.virt";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
