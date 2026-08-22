{
  delib,
  lib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "osa.de.niri";

  options = { myconfig, ... }: {
    osa.de.niri.enable = delib.boolOption myconfig.user.gui.enable;
    osa.de.niri.launcher.default = lib.mkOption {
      type = lib.types.attrs;
      default = {
        pkg = myconfig.osa.apps.walker.pkg;
      };
    };
  };

  nixos.always.imports = [ inputs.niri-pkgs.nixosModules.niri ];

  nixos.ifEnabled = {
    programs.niri.enable = true;
    # niri-unstable still hard-requires libdisplay-info 0.2 (its Rust
    # bindings haven't been updated for 0.3's API yet), but nixpkgs has
    # removed the versioned `libdisplay-info_0_2` attribute entirely. Build
    # 0.2.0 ourselves and feed it in via an overlay so niri-flake's
    # `callPackage` auto-arg resolution picks it up instead of nixpkgs'
    # throwing alias.
    nixpkgs.overlays = [
      (final: prev: {
        libdisplay-info_0_2 = prev.libdisplay-info.overrideAttrs (old: {
          version = "0.2.0";
          src = prev.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "emersion";
            repo = "libdisplay-info";
            tag = "0.2.0";
            hash = "sha256-6xmWBrPHghjok43eIDGeshpUEQTuwWLXNHg7CnBUt3Q=";
          };
        });
      })
      inputs.niri-pkgs.overlays.niri
    ];
    # niri-unstable's `niri-session` wrapper calls `systemctl --user
    # import-environment` with no variable list, which systemd now warns
    # is deprecated ("Calling import-environment without a list of
    # variable names is deprecated"). That warning gets printed straight
    # to the VT during the greeter -> session handoff. Patch it to pass
    # the same explicit list niri's own `--session` mode uses internally.
    programs.niri.package = pkgs.niri-unstable.overrideAttrs (old: {
      postFixup = (old.postFixup or "") + ''
        substituteInPlace $out/bin/niri-session \
          --replace-fail \
            'systemctl --user import-environment' \
            'systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP NIRI_SOCKET'
      '';
    });

    # use the gnome polkit rather than the kde one installed
    # by default with the niri flake
    systemd.user.services.niri-flake-polkit = {
      enable = false;
    };

    environment.variables.NIXOS_OZONE_WL = "1";

    environment.variables.QT_QPA_PLATFORMTHEME = "kde";

    environment.sessionVariables.SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/keyring/ssh";

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
