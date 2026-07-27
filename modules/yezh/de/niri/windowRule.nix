{ delib, lib, pkgs, config, ... }:
delib.module {
  name = "yezh.de.niri";

  home.ifEnabled = {
    programs.niri.settings.window-rules = [
      {
        geometry-corner-radius = {
          top-left = 8.0;
          top-right = 8.0;
          bottom-left = 8.0;
          bottom-right = 8.0;
        };
        clip-to-geometry = true;
      }

      {
        matches = [
          { app-id = "librewolf"; }
          { app-id = "zen"; }
          { app-id = "telegram-desktop"; }
        ];
        open-maximized = true;
      }

      {
        matches = [
          { title = "Extension:"; }
        ];
        open-floating = true;
      }

      {
        matches = [
          { app-id = "scrcpy"; }
        ];
        open-floating = true;
      }
    ];
  };
}
