{ delib, ... }:
delib.host {
  name = "nixlaptop";

  rice = "niri";
  type = "nixlaptop";

  myconfig = {
    desktop.enable = true;

    shell.name = "zsh";

    programs = {
      gui = {
        browser.librewolf.enable = false;
        media.reaper.enable = false;
      };
    };

    system.libvirtd.enable = true;
  };

  home.home.stateVersion = "26.05";
  nixos.system.stateVersion = "26.05";

  nixos = {
    zramSwap.enable = true;
    time.timeZone = "Asia/Yekaterinburg";

    swapDevices = [ { device = "/swap/swapfile"; } ];
    boot.resumeDevice = "/dev/mapper/cryptroot";
    boot.kernelParams = [
      "resume_offset=533760"
    ];

    powerManagement.enable = true;
    services.power-profiles-daemon.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true; # автоматически включать Bluetooth при загрузке
    };

    # Включаем графический менеджер Blueman (очень удобен для трея)
    services.blueman.enable = true;

    services.myPower.enable = false;
  };
}
