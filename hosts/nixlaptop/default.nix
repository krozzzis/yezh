{ delib, ... }:
delib.host {
  name = "nixlaptop";

  rice = "niri";
  type = "nixlaptop";

  myconfig = {
    programs = {
      wezterm.enable = true;
      telegram.enable = true;
      librewolf.enable = false;
      firefox.enable = true;
      throne.enable = true;
      zed.enable = true;
      zen-browser.enable = true;
    };
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
