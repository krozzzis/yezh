{ delib, lib, pkgs, inputs, ... }:
delib.module {
  name = "osa.de.dms";

  options = delib.singleEnableOption false;

  home.always.imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.nixosModules.default
    inputs.dms.homeModules.niri
    # dms's niri integration (inputs.dms.homeModules.niri) references
    # `config.lib.niri.actions`, which is provided by the niri-flake
    # home-manager module. Without it the entire home configuration fails
    # to evaluate.
    inputs.niri-pkgs.homeModules.niri
  ];
  nixos.always.imports = [ inputs.dms.nixosModules.dank-material-shell ];

  nixos.ifEnabled = { myconfig, ... }: {
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/${myconfig.user.constants.username}";
    };

    # dms-greeter's compositor (niri) is a real DRM/KMS Wayland compositor,
    # so it can take over the display cleanly on its own. By default greetd
    # waits for plymouth-quit-wait.service before it even starts, which
    # drops the console to text mode for a moment before the greeter has
    # anything painted -- that's the visible flicker (and where stray boot
    # console text, like systemd deprecation warnings, can flash through).
    # Letting the greeter manage the handoff itself removes that gap.
    services.greetd.greeterManagesPlymouth = true;

    # Serves the user's face icon (~/.face) to the greeter over D-Bus.
    # The greeter runs as an unprivileged user and cannot read ~/.face
    # inside the 0700 home, so AccountsService (running as root) is what
    # makes the avatar show on the dms login/lock screen.
    services.accounts-daemon.enable = true;

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
