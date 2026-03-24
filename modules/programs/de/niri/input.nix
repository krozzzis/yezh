{ delib, ... }:
delib.module {
  name = "programs.niri";

  home.ifEnabled = {
    programs.niri.settings = {
      input = {
        touchpad = {
          tap = true;
          natural-scroll = true;
          # accel-speed 0.2
          # accel-profile "flat"
          # scroll-factor 1.0
          # scroll-factor vertical=1.0 horizontal=-2.0
          # scroll-method "two-finger"
          # scroll-button 273
          # scroll-button-lock
          # tap-button-map "left-middle-right"
          # click-method "clickfinger"
          # left-handed
          # disabled-on-external-mouse
          middle-emulation = true;
        };
      };

      gestures = {
        hot-corners.enable = false;
      };
    };
  };
}
