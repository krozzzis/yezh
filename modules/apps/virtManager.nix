{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.virtManager";

  options = { myconfig, ... }: {
    apps.virtManager.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  nixos.ifEnabled = { myconfig, ... }: {
    programs.virt-manager.enable = true;

    virtualisation.libvirtd.enable = true;
    users.users.${myconfig.constants.username}.extraGroups = [ "libvirtd" ];
  };
}
