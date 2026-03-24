{ delib, ... }:
delib.module {
  name = "programs.hyprland";

  home.ifEnabled = {
    wayland.windowManager.hyprland = {
      settings = {
        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 20;
        };
      };
    };
  };
}
