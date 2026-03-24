{ delib, ... }:
delib.module {
  name = "programs.niri";

  home.ifEnabled = {
    programs.niri.settings = {
      layout = {
        gaps = 8;

        border.width = 2;
      };
    };
  };
}
