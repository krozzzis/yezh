{ delib, ... }:
delib.module {
  name = "osa.de.niri";

  home.ifEnabled = { myconfig, ... }: {
    programs.niri.settings = {
      layout = {
        gaps = myconfig.osa.ui.gap;

        border.width = 2;
      };
    };
  };
}
