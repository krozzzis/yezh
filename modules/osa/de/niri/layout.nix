{ delib, ... }:
delib.module {
  name = "osa.de.niri";

  home.ifEnabled = {
    programs.niri.settings = {
      layout = {
        gaps = 8;

        border.width = 2;
      };
    };
  };
}
