{ delib, ... }:

delib.module {
  name = "yezh.system.libvirtd";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = { myconfig, ... }: {
    virtualisation.libvirtd.enable = true;

    users.users.${myconfig.user.constants.username}.extraGroups = [ "libvirtd" ];
  };
}
