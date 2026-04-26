{ delib, ... }:
delib.rice {
  name = "niri";

  myconfig = {
    programs.niri.enable = true;
    programs.noctalia.enable = true;
    programs.walker.enable = true;
    programs.audacity.enable = true;
    programs.reaper.enable = false;
    programs.virt.enable = true;
    programs.tor.enable = true;
    programs.winapps.enable = true;
    programs.anytype.enable = false;
    programs.android.enable = true;
    programs.kdeconnect.enable = true;
    programs.yggdrasil.enable = true;
    programs.cosmic.enable = true;
    programs.vlc.enable = true;
    programs.obs.enable = true;
    programs.qbittorrent.enable = true;
    programs.ai.opencode.enable = true;
    programs.ai.antigravity.enable = true;
    programs.libreoffice.enable = true;
    programs.prismlauncher.enable = true;
    system.sddm.enable = true;
    shell.uutils.enable = true;
  };

  nixos = {
    services.displayManager.defaultSession = "niri";
  };
}
