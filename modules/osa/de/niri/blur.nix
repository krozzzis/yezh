{ delib, ... }:
delib.module {
  name = "osa.de.niri";

  home.ifEnabled = { myconfig, ... }: {
    programs.niri.settings.window-rules =
      let
        r = myconfig.osa.ui.cornerRadius * 1.0;
      in
      [
        {
          matches = [
            { app-id = "^org\\.wezfurlong\\.wezterm$"; }
          ];
          # Окно должно быть полупрозрачным, иначе blur не видно. Прозрачность задаётся в wezterm (window_background_opacity),
          # здесь только убираем бордер с фоном, чтобы он не просвечивал.
          draw-border-with-background = false;
          geometry-corner-radius = {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
        }
      ];
  };
}
