{ delib, lib, pkgs, ... }:
delib.host {
  name = "nixlaptop";

  rice = "niri";

  myconfig = { myconfig, ... }: let
    inherit (lib) getName;

    app = pkg: { spawn = [ (getName pkg) ]; };
    wm = { mod = [ "Mod" ]; };
    wmCtrl = { mod = [ "Mod" "Ctrl" ]; };
  in {
    dev.enable = true;
    desktop.enable = true;

    shell.default = myconfig.shell.fish;
    editor.default = myconfig.editor.nixvim;
    browser.default = myconfig.browser.zenBrowser;
    fileManager.default = myconfig.fileManager.nautilus;
    imageViewer.default = myconfig.apps.swayimg;
    pdfViewer.default = myconfig.apps.cosmic.reader;
    musicPlayer.default = myconfig.media.vlc;
    videoPlayer.default = myconfig.media.vlc;

    editor.nixvim.enable = true;
    browser.librewolf.enable = false;
    media.reaper.enable = true;
    terminal.wezterm.enable = true;
    apps.wireshark.enable = true;
    apps.swayimg.enable = true;
    apps.qpwgraph.enable = true;
    apps.cosmic.enable = true;
    apps.arduinoIde.enable = true;

    shell.fzf.enable = true;

    system.libvirtd.enable = true;
    system.audio.enable = true;

    config.shortcuts = [
      # -- dynamic app spawns
      (wm // { key = "Return"; action = app myconfig.terminal.default.pkg; title = "Open Terminal"; })
      (wm // { key = "P";      action = app myconfig.de.niri.launcher.default.pkg; title = "Open Launcher"; })
      (wm // { key = "E";      action = app myconfig.fileManager.default.pkg; title = "Open File Manager"; })
      (wmCtrl // { key = "L";  action = app myconfig.browser.default.pkg; title = "Open Browser"; })
    ];
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

    environment.systemPackages = [ pkgs.python3 ];

    boot.tmp.useTmpfs = true;
  };
}
