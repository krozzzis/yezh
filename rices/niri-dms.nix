{ delib, ... }:
delib.rice {
  name = "niri-dms";

  myconfig = {
    programs.niri.enable = true;
    programs.dms.enable = true;
    programs.walker.enable = true;
    programs.audacity.enable = true;
    programs.reaper.enable = true;
    programs.virt.enable = true;
    programs.winapps.enable = true;
    programs.anytype.enable = false;
    programs.cosmic.enable = true;
    programs.vlc.enable = true;
    programs.obs.enable = true;
    programs.qbittorrent.enable = true;
    programs.ai.opencode.enable = true;
    programs.libreoffice.enable = true;
    system.sddm.enable = false;
    system.greetd.enable = false;
    shell.uutils.enable = true;
  };

  nixos = {
    services.displayManager.defaultSession = "niri";
  };
}
