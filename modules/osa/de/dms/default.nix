{
  delib,
  lib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "osa.de.dms";

  options = delib.singleEnableOption false;

  # DMS теперь полностью через home-manager.
  # NixOS-модуль DankMaterialShell (inputs.dms.nixosModules) больше не импортируется:
  # система получает только greeter через nixpkgs (services.displayManager.dms-greeter),
  # а сама оболочка управляется programs.dank-material-shell из homeManager.
  home.always.imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.dms-plugin-registry.homeModules.default
  ];

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
    # Ранее эти сервисы тянулись транзитивно из inputs.dms.nixosModules.dank-material-shell;
    # при переходе на home-manager модуль включаем их явно (mkDefault, чтобы не перетирать хост).
    services.power-profiles-daemon.enable = lib.mkDefault true;
    services.geoclue2.enable = lib.mkDefault true;
    security.polkit.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      libappindicator
      upower
    ];
  };

  home.ifEnabled =
    { myconfig, ... }:
    let
      # Глобальная прозрачность (0.0-1.0, default 0.9 = 90%) из user.ui.transparency / osa.ui.transparency.
      # osa.ui.transparency по умолчанию наследует user.ui.transparency.
      transparency =
        if myconfig ? osa && myconfig.osa ? ui && myconfig.osa.ui ? transparency then
          myconfig.osa.ui.transparency
        else
          myconfig.user.ui.transparency;
      baseSettings = {
        acLockTimeout = 600;
        currentThemeName = "dynamic";
        controlCenterWidgets = [
            {
            enabled = true;
            id = "volumeSlider";
            width = 50;
          }
            {
            enabled = true;
            id = "brightnessSlider";
            width = 50;
          }
            {
            enabled = true;
            id = "wifi";
            width = 50;
          }
            {
            enabled = true;
            id = "bluetooth";
            width = 50;
          }
            {
            enabled = true;
            id = "audioOutput";
            width = 50;
          }
            {
            enabled = true;
            id = "audioInput";
            width = 50;
          }
            {
            enabled = true;
            id = "darkMode";
            width = 50;
          }
            {
            enabled = true;
            id = "nightMode";
            width = 50;
          }
            {
            id = "plugin_dankKDEConnect";
            enabled = true;
            width = 50;
          }
          ];
        acMonitorTimeout = 300;
        batterySuspendTimeout = 600;
        workspaceOccupiedColorMode = "s";
        matugenTemplateHyprland = false;
        batterySuspendBehavior = 2;
        batteryLockTimeout = 300;
        cornerRadius = 12;
        updaterHideWidget = true;
        notificationHistoryEnabled = false;
        barConfigs = [
            {
            autoHide = false;
            autoHideDelay = 250;
            borderColor = "surfaceText";
            borderEnabled = false;
            borderOpacity = 0.39;
            borderThickness = 1;
            bottomGap = 0;
            centerWidgets = [
                {
                enabled = true;
                id = "workspaceSwitcher";
              }
              ];
            clickThrough = false;
            enabled = true;
            fontScale = 1;
            gothCornerRadiusOverride = false;
            gothCornerRadiusValue = 12;
            gothCornersEnabled = false;
            iconScale = 1;
            id = "default";
            innerPadding = 4;
            leftWidgets = [
                "launcherButton"
                {
                enabled = true;
                id = "systemTray";
              }
              ];
            maximizeDetection = true;
            maximizeWidgetIcons = false;
            maximizeWidgetText = false;
            name = "Main Bar";
            noBackground = true;
            openOnOverview = true;
            popupGapsAuto = true;
            popupGapsManual = 5;
            position = 3;
            removeWidgetPadding = false;
            rightWidgets = [
                {
                id = "keyboard_layout_name";
                enabled = true;
                keyboardLayoutNameCompactMode = false;
              }
                {
                id = "battery";
                enabled = true;
              }
                {
                id = "volumeMixer";
                enabled = true;
              }
                {
                id = "controlCenterButton";
                enabled = true;
              }
                {
                id = "clock";
                enabled = true;
                clockCompactMode = true;
              }
              ];
            screenPreferences = [ "all" ];
            scrollXBehavior = "column";
            scrollYBehavior = "workspace";
            shadowIntensity = 0;
            showOnLastDisplay = true;
            spacing = 4;
            squareCorners = false;
            transparency = 1;
            visible = true;
            widgetOutlineColor = "primary";
            widgetOutlineEnabled = false;
            widgetPadding = 8;
            widgetTransparency = 1;
          }
          ];
        currentThemeCategory = "dynamic";
        lockBeforeSuspend = true;
        batteryMonitorTimeout = 120;
        acSuspendBehavior = 2;
        matugenTemplateMangowc = false;
        acSuspendTimeout = 1800;
      };
      barConfigs' = map (
        bar: bar // {
          transparency = transparency;
          widgetTransparency = transparency;
        }
      ) baseSettings.barConfigs;
    in
    {
      programs.dank-material-shell = {
        enable = true;
        niri = {
          includes.enable = true; # Enable config includes hack. Enabled by default.
        };
        systemd = {
          enable = true; # Systemd service for auto-start
          restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
          # home-manager модуль по умолчанию берёт wayland.systemd.target,
          # но для niri нам нужен graphical-session.target (как в старом nixos-модуле),
          # иначе DMS не стартует и spotlight не отвечает.
          target = lib.mkDefault "graphical-session.target";
        };

        # Core features
        enableSystemMonitoring = true; # System monitoring widgets (dgop)
        enableVPN = true; # VPN management widget
        enableDynamicTheming = true; # Wallpaper-based theming (matugen)
        enableCalendarEvents = true; # Calendar integration (khal)

        settings = baseSettings // {
          # Прозрачность для всех элементов DMS
          popupTransparency = transparency;
          dockTransparency = transparency;
          desktopClockTransparency = transparency;
          systemMonitorTransparency = transparency;
          # Блюр для всех слоёв
          blurEnabled = true;
          blurForegroundLayers = true;
          blurBorderEnabled = true;
          # Переопределяем бары глобальной прозрачностью
          barConfigs = barConfigs';
          # Шрифты из глобальных user.fonts — иначе fallback даёт неестественно большой размер
          fontFamily = myconfig.user.fonts.regular.name;
          monoFontFamily = myconfig.user.fonts.monospace.name;
        };

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
          # Super+Shift+P (win+shift+p) — запуск spotlight. В niri Mod == Super,
          # но для надёжности ставим оба имени. DMS 1.5 понимает и "spotlight" и "launcher"
          # (они синонимы в DMSShellIPC.qml), на всякий случай биндим оба.
          "Mod+Shift+P" = {
            hotkey-overlay.title = "Toggle Spotlight";
            action.spawn = [
              "dms"
              "ipc"
              "call"
              "spotlight"
              "toggle"
            ];
          };
          "Super+Shift+P" = {
            hotkey-overlay.title = "Toggle Spotlight";
            action.spawn = [
              "dms"
              "ipc"
              "call"
              "spotlight"
              "toggle"
            ];
          };
        };
      };
    };
}
