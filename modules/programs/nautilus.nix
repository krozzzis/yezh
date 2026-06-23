{ delib, pkgs, ... }:
delib.module {
  name = "programs.nautilus";

  options = delib.singleEnableOption false;

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
