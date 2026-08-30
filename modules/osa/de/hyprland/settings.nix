{ delib, ... }:
delib.module {
  name = "osa.de.hyprland";

  home.ifEnabled = { myconfig, ... }: {
    wayland.windowManager.hyprland = {
      settings = {
        general = {
          gaps_in = myconfig.osa.ui.gap;
          gaps_out = myconfig.osa.ui.gap;
          border_size = 2;
        };
        decoration = {
          rounding = myconfig.osa.ui.cornerRadius;
        };
      };
    };
  };
}
