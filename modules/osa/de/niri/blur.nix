{ delib, ... }:
delib.module {
  name = "osa.de.niri";

  home.ifEnabled = {
    programs.niri.settings.window-rules = [
      {
        matches = [
          { app-id = "^org\\.wezfurlong\\.wezterm$"; }
        ];
        # Окно должно быть полупрозрачным, иначе blur не видно. Прозрачность задаётся в wezterm (window_background_opacity),
        # здесь только убираем бордер с фоном, чтобы он не просвечивал.
        draw-border-with-background = false;
        geometry-corner-radius = {
          top-left = 8.0;
          top-right = 8.0;
          bottom-left = 8.0;
          bottom-right = 8.0;
        };
        clip-to-geometry = true;
      }
    ];
  };
}
