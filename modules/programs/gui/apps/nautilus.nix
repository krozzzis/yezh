{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.apps.nautilus";

  options = { myconfig, ... }: {
    programs.gui.apps.nautilus.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.apps.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      nautilus
      gnome.gvfs
      udiskie
      usbutils
      apfs-fuse
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
