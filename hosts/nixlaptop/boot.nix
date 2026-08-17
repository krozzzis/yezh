{ delib, ... }:
delib.host {
  name = "nixlaptop";

  nixos = {
    boot = {
      initrd.systemd.enable = true;

      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        timeout = 0;
      };

      # theme/themePackages come from osa.system.branding.plymouth.*
      plymouth.enable = true;

      # Enable "Silent boot"
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
      ];
    };
  };
}
