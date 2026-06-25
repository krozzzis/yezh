{ delib, lib, pkgs, ... }:
delib.module {
  name = "fileManager.nautilus";

  options = { myconfig, ... }: {
    fileManager.nautilus.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
    fileManager.nautilus.pkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.nautilus;
    };
  };

  nixos.ifEnabled = { myconfig, ... }: {
    environment.systemPackages = [
      myconfig.fileManager.nautilus.pkg
      pkgs.gnome.gvfs
      pkgs.udiskie
      pkgs.usbutils
      pkgs.apfs-fuse
    ];

    boot.supportedFilesystems = [ "ntfs" ];
  };

  home.ifEnabled = {
    services.udiskie = {
      enable = true;
      # automount = true;  # по умолчанию часто включено
      notify = true;
    };
  };
}
