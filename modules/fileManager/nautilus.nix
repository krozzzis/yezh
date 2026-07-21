{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "fileManager.nautilus";

  options = { myconfig, ... }: {
    fileManager.nautilus.enable = delib.boolOption myconfig.gui.enable;
    fileManager.nautilus.pkg = delib.packageOption pkgs.nautilus;
  };

  nixos.ifEnabled = { myconfig, ... }: {
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    environment.systemPackages = [
      myconfig.fileManager.nautilus.pkg
      pkgs.usbutils
      pkgs.apfs-fuse
    ];

    boot.supportedFilesystems = [ "ntfs" ];
  };

}
