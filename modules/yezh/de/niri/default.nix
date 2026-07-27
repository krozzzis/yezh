{ delib, lib, inputs, pkgs, ... }:
delib.module {
  name = "yezh.de.niri";

  options = { myconfig, ... }: {
    yezh.de.niri.enable = delib.boolOption myconfig.user.gui.enable;
    yezh.de.niri.launcher.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.yezh.apps.walker.pkg; };
    };
  };

  nixos.always.imports = [ inputs.niri.nixosModules.niri ];

  nixos.ifEnabled = {
    programs.niri.enable = true;
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs.niri.package = pkgs.niri-unstable;

    # use the gnome polkit rather than the kde one installed
    # by default with the niri flake
    systemd.user.services.niri-flake-polkit = { enable = false; };

    environment.variables.NIXOS_OZONE_WL = "1";

    environment.variables.QT_QPA_PLATFORMTHEME = "kde";

    environment.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome # нужен для ScreenCast (запись экрана в OBS и т.п.)
      ];
    };

    # Важно: GTK-портал не реализует ScreenCast, поэтому запись экрана
    # (OBS, screen sharing) явно направляется на gnome-портал,
    # а выбор файлов остаётся на GTK-портале.
    xdg.portal.config = {
      niri = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      };
      common.default = [ "gtk" ];
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      wayland-utils
      libnotify
      brightnessctl
      networkmanagerapplet
      pamixer
      pulsemixer
      pavucontrol
      wtype
    ];

  };

}
