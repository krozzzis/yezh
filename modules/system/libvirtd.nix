{ delib, ... }:

delib.module {
  name = "system.libvirtd";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = { myconfig, ... }: {
    virtualisation.libvirtd.enable = true;

    users.users.${myconfig.constants.username}.extraGroups = [ "libvirtd" ];
  };
}
