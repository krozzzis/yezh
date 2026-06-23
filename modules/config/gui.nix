{ delib, lib, ... }:

delib.module {
  name = "gui";

  options = { myconfig, ... }: {
    gui.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GUI mode (includes graphical programs like libreoffice, firefox)";
    };
    gui.browser.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
      description = "Enable browser category (firefox, zen-browser, librewolf, tor)";
    };
    gui.ai.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
      description = "Enable AI category (opencode, antigravity)";
    };
    gui.media.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
      description = "Enable media category (vlc, obs, audacity, reaper, qbittorrent)";
    };
    gui.office.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
      description = "Enable office category (libreoffice)";
    };
    gui.comms.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
      description = "Enable communication category (telegram, kdeconnect)";
    };
    gui.dev.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
      description = "Enable development category (zed)";
    };
    gui.de.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
      description = "Enable desktop environments (niri, dms, hyprland, xfce)";
    };
    gui.apps.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
      description = "Enable miscellaneous apps (wezterm, nautilus, walker, throne, winapps, android, cosmic, prismlauncher, virt-manager)";
    };
  };
}
