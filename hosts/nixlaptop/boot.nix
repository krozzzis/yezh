{ delib, pkgs, ... }:
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

      plymouth = {
        enable = true;
        theme = "nixos-bgrt";
        themePackages = with pkgs; [
          nixos-bgrt-plymouth
        ];
      };

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
