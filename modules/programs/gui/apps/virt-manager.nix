{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.apps.virt-manager";

  options = { myconfig, ... }: {
    programs.gui.apps.virt-manager.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.apps.enable;
    };
  };

  nixos.ifEnabled = { myconfig, ... }: {
    programs.virt-manager.enable = true;

    virtualisation.libvirtd.enable = true;
    users.users.${myconfig.constants.username}.extraGroups = [ "libvirtd" ];
  };
}
