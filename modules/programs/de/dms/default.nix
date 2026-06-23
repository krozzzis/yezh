{ delib, lib, pkgs, inputs, ... }:
delib.module {
  name = "programs.dms";

  options = delib.singleEnableOption false;

  home.always.imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.nixosModules.default
    inputs.dms.homeModules.niri
  ];
  nixos.always.imports = [ inputs.dms.nixosModules.dank-material-shell ];

  nixos.ifEnabled = {
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/krozzzis";
    };

    services.upower.enable = true;

    environment.systemPackages = with pkgs; [
      libappindicator
      upower
    ];
  };

  home.ifEnabled = { myconfig, ...}: {
    programs.dank-material-shell = {
      enable = true;
      niri = {
      #   enableKeybinds = true;   # Sets static preset keybinds
        includes.enable = true;    # Enable config includes hack. Enabled by default.
      #   enableSpawn = true;      # Auto-start DMS with niri, if enabled
      };
      systemd = {
        enable = true;             # Systemd service for auto-start
        restartIfChanged = true;   # Auto-restart dms.service when dank-material-shell changes
      };

      # Core features
      enableSystemMonitoring = true;     # System monitoring widgets (dgop)
      enableVPN = true;                  # VPN management widget
      enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
      # enableAudioWavelength = true;      # Audio visualizer (cava)
      enableCalendarEvents = true;       # Calendar integration (khal)
      # enableClipboardPaste = true;       # Pasting items from the clipboard (wtype)

      settings = lib.importJSON ./settings.json;

      plugins = {
        dankBatteryAlerts.enable = true;
        volumeMixer.enable = true;
        dankKDEConnect.enable = true;
      };
    };

    programs.niri.settings = {
      binds = {
        "Mod+B" = {
          hotkey-overlay.title = "Toggle Bar Visibility";
          action.spawn = [
            "dms"
            "ipc"
            "call"
            "bar"
            "toggle"
            "index"
            "0"
          ];
        };
      };
    };

    #systemd.user.services.niri-flake-polkit = { enable = false; };
  };
}
