{ delib, inputs, ... }:
delib.module {
  name = "programs.dms";

  options = delib.singleEnableOption false;

  home.always.imports = [ inputs.dms.homeModules.dank-material-shell ];
  nixos.always.imports = [ inputs.dms.nixosModules.dank-material-shell ];

  nixos.ifEnabled = {
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
    };
  };

  home.ifEnabled = { myconfig, ...}: {
    programs.dank-material-shell = {
      enable = true;
      # niri = {
      #   enableKeybinds = true;   # Sets static preset keybinds
      #   enableSpawn = true;      # Auto-start DMS with niri, if enabled
      # };
      systemd = {
        enable = true;             # Systemd service for auto-start
        restartIfChanged = true;   # Auto-restart dms.service when dank-material-shell changes
      };

      # Core features
      enableSystemMonitoring = true;     # System monitoring widgets (dgop)
      enableVPN = true;                  # VPN management widget
      enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
      # enableAudioWavelength = true;      # Audio visualizer (cava)
      # enableCalendarEvents = true;       # Calendar integration (khal)
      # enableClipboardPaste = true;       # Pasting items from the clipboard (wtype)

      settings = {
        theme = "dark";
        dynamicTheming = true;
      };
    };
  };
}
