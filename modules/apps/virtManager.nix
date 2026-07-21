{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.virtManager";

  options = { myconfig, ... }: {
    apps.virtManager.enable = delib.boolOption myconfig.gui.enable;
  };

  nixos.ifEnabled = { myconfig, ... }: {
    programs.virt-manager.enable = true;

    virtualisation.libvirtd.enable = true;
    users.users.${myconfig.constants.username}.extraGroups = [ "libvirtd" ];
  };
}
