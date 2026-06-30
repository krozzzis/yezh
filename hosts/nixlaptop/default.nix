{ delib, ... }:
delib.host {
  name = "nixlaptop";

  rice = "niri";

  myconfig = { myconfig, ... }: {
    dev.enable = true;
    desktop.enable = true;

    shell.default = myconfig.shell.fish;
    editor.default = myconfig.editor.nixvim;
    browser.default = myconfig.browser.zenBrowser;
    fileManager.default = myconfig.fileManager.nautilus;
    musicPlayer.default = myconfig.media.vlc;
    videoPlayer.default = myconfig.media.vlc;

    editor.nixvim.enable = true;
    browser.librewolf.enable = false;
    media.reaper.enable = true;
    terminal.wezterm.enable = true;
    apps.wireshark.enable = true;

    shell.fzf.enable = true;

    system.libvirtd.enable = true;
    system.audio.enable = true;
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
      powerOnBoot = true;
    };

    services.blueman.enable = true;
  };
}
