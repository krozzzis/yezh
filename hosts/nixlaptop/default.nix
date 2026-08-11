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

    user.shell.default = myconfig.osa.shell.fish;
    user.editor.default = myconfig.osa.editor.nixvim;
    user.browser.default = myconfig.osa.browser.zenBrowser;
    user.fileManager.default = myconfig.osa.fileManager.nautilus;
    user.imageViewer.default = myconfig.osa.apps.swayimg;
    user.pdfViewer.default = myconfig.osa.apps.cosmic.reader;
    user.musicPlayer.default = myconfig.osa.media.vlc;
    user.videoPlayer.default = myconfig.osa.media.vlc;

    osa.editor.nixvim.enable = true;
    osa.browser.librewolf.enable = false;
    osa.media.reaper.enable = true;
    osa.media.patchbay.enable = true;
    osa.terminal.wezterm.enable = true;
    osa.apps.wireshark.enable = true;
    osa.apps.swayimg.enable = true;
    osa.apps.qpwgraph.enable = true;
    osa.apps.cosmic.enable = true;
    osa.apps.arduinoIde.enable = true;

    osa.shell.fzf.enable = true;

    osa.system.libvirtd.enable = true;
    osa.system.audio.enable = true;

    user.shortcuts = [
      # -- dynamic app spawns
      (wm // { key = "Return"; action = app myconfig.user.terminal.default.pkg; title = "Open Terminal"; })
      (wm // { key = "P";      action = app myconfig.osa.de.niri.launcher.default.pkg; title = "Open Launcher"; })
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

    # Lets `nix build` cross-compile aarch64 hosts (e.g. pi-backup) via QEMU emulation.
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    # Root is LUKS+btrfs (see disko.nix); ZFS is unused here but its default
    # inclusion drags in a separate out-of-tree kernel module build.
    boot.supportedFilesystems.zfs = false;
  };
}
