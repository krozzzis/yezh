{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "yezh.fileManager.nautilus";

  options = { myconfig, ... }: {
    yezh.fileManager.nautilus.enable = delib.boolOption myconfig.user.gui.enable;
    yezh.fileManager.nautilus.pkg = delib.packageOption pkgs.nautilus;
  };

  nixos.ifEnabled = { myconfig, ... }: {
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    environment.systemPackages = [
      myconfig.yezh.fileManager.nautilus.pkg
      pkgs.usbutils
      pkgs.apfs-fuse
    ];

    boot.supportedFilesystems = [ "ntfs" ];
  };

}
