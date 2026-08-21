{ delib, lib, ... }:
delib.module {
  name = "osa.de.wallpaper";

  options = { myconfig, ... }: {
    osa.de.wallpaper = {
      enable = delib.description (delib.boolOption true)
        "Use the bundled OSA wallpaper as the default background for the display manager / greeter.";

      file = lib.mkOption {
        type = lib.types.path;
        default = ./assets/wallpaper.png;
        description = "Wallpaper image used by the OSA display manager / greeter.";
      };
    };
  };

  home.ifEnabled = { myconfig, ... }: {
    # dms-greeter (used by the niri rice) renders this as the login/lock
    # screen wallpaper and feeds it to matugen for dynamic theming.
    programs.dank-material-shell.settings.greeterWallpaperPath = myconfig.osa.de.wallpaper.file;
  };
}
