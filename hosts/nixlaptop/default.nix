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
    user.dev.enable = true;
    user.desktop.enable = true;

    user.shell.default = myconfig.yezh.shell.fish;
    user.editor.default = myconfig.yezh.editor.nixvim;
    user.browser.default = myconfig.yezh.browser.zenBrowser;
    user.fileManager.default = myconfig.yezh.fileManager.nautilus;
    user.imageViewer.default = myconfig.yezh.apps.swayimg;
    user.pdfViewer.default = myconfig.yezh.apps.cosmic.reader;
    user.musicPlayer.default = myconfig.yezh.media.vlc;
    user.videoPlayer.default = myconfig.yezh.media.vlc;

    yezh.editor.nixvim.enable = true;
    yezh.browser.librewolf.enable = false;
    yezh.media.reaper.enable = true;
    yezh.terminal.wezterm.enable = true;
    yezh.apps.wireshark.enable = true;
    yezh.apps.swayimg.enable = true;
    yezh.apps.qpwgraph.enable = true;
    yezh.apps.cosmic.enable = true;
    yezh.apps.arduinoIde.enable = true;

    yezh.shell.fzf.enable = true;

    yezh.system.libvirtd.enable = true;
    yezh.system.audio.enable = true;

    user.shortcuts = [
      # -- dynamic app spawns
      (wm // { key = "Return"; action = app myconfig.user.terminal.default.pkg; title = "Open Terminal"; })
      (wm // { key = "P";      action = app myconfig.yezh.de.niri.launcher.default.pkg; title = "Open Launcher"; })
      (wm // { key = "E";      action = app myconfig.user.fileManager.default.pkg; title = "Open File Manager"; })
      (wmCtrl // { key = "L";  action = app myconfig.user.browser.default.pkg; title = "Open Browser"; })
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
