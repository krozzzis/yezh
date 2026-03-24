{ delib, ... }:
delib.module {
  name = "programs.niri";

  home.ifEnabled = {
    programs.niri.settings = {
      binds = {
        "Mod+Return" = {
          hotkey-overlay.title = "Open Terminal";
          action.spawn = [
            "wezterm"
          ];
        };

        "Mod+P" = {
          hotkey-overlay.title = "Open Launcher";
          action.spawn = [
            "walker"
          ];
        };

        "Mod+E" = {
          hotkey-overlay.title = "Open File Manager";
          action.spawn = [
            "cosmic-files"
          ];
        };

        "Mod+B" = {
          hotkey-overlay.title = "Toggle Bar Visibility";
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "bar"
            "toggle"
          ];
        };

        "Mod+Ctrl+L" = {
          hotkey-overlay.title = "Open Browser";
          action.spawn = [
            "librewolf"
          ];
        };

        # -- volume control
        "XF86AudioRaiseVolume" = {
          hotkey-overlay.title = "Volume Up";
          action.spawn = [
            "pamixer"
            "-i"
            "2"
          ];
        };
        "XF86AudioLowerVolume" = {
          hotkey-overlay.title = "Volume Down";
          action.spawn = [
            "pamixer"
            "-d"
            "2"
          ];
        };
        "XF86AudioMute" = {
          hotkey-overlay.title = "Volume Mute";
          action.spawn = [
            "pamixer"
            "-t"
          ];
        };
        "XF86AudioMicMute" = {
          hotkey-overlay.title = "Mic Mute";
          action.spawn = [
            "pamixer"
            "--default-source"
            "-t"
          ];
        };
        "XF86MonBrightnessUp" = {
          hotkey-overlay.title = "Brightness Up";
          action.spawn = [
            "brightnessctl"
            "set"
            "+5%"
          ];
        };
        "XF86MonBrightnessDown" = {
          hotkey-overlay.title = "Brightness Down";
          action.spawn = [
            "brightnessctl"
            "set"
            "5%-"
          ];
        };

        # Open/close the Overview: a zoomed-out view of workspaces and windows.
        # You can also move the mouse into the top-left hot corner,
        # or do a four-finger swipe up on a touchpad.
        "Mod+Tab".action.toggle-overview = [ ];

        "Mod+Shift+C".action.close-window = [ ];

        "Mod+Left".action.focus-column-left = [ ];
        "Mod+Down".action.focus-window-or-workspace-down = [ ];
        "Mod+Up".action.focus-window-or-workspace-up = [ ];
        "Mod+Right".action.focus-column-right = [ ];
        "Mod+H".action.focus-column-left = [ ];
        "Mod+J".action.focus-window-or-workspace-down = [ ];
        "Mod+K".action.focus-window-or-workspace-up = [ ];
        "Mod+L".action.focus-column-right = [ ];

        "Mod+Shift+Left".action.move-column-left = [ ];
        "Mod+Shift+Down".action.move-window-down-or-to-workspace-down = [ ];
        "Mod+Shift+Up".action.move-window-up-or-to-workspace-up = [ ];
        "Mod+Shift+Right".action.move-column-right = [ ];
        "Mod+Shift+H".action.move-column-left = [ ];
        "Mod+Shift+J".action.move-window-down-or-to-workspace-down = [ ];
        "Mod+Shift+K".action.move-window-up-or-to-workspace-up = [ ];
        "Mod+Shift+L".action.move-column-right = [ ];

        "Mod+Page_Down".action.focus-workspace-down = [ ];
        "Mod+Page_Up".action.focus-workspace-up = [ ];
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [ ];
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [ ];

        "Mod+Shift+Page_Down".action.move-workspace-down = [ ];
        "Mod+Shift+Page_Up".action.move-workspace-up = [ ];

        # // You can bind mouse wheel scroll ticks using the following syntax.
        # // These binds will change direction based on the natural-scroll setting.
        # //
        # // To avoid scrolling through workspaces really fast, you can use
        # // the cooldown-ms property. The bind will be rate-limited to this value.
        # // You can set a cooldown on any bind, but it's most useful for the wheel.
        "Mod+WheelScrollDown" = { cooldown-ms = 150; action.focus-workspace-down = [ ]; };
        "Mod+WheelScrollUp"   = { cooldown-ms = 150; action.focus-workspace-up = [ ]; };

        "Mod+TouchpadScrollDown" = { cooldown-ms = 150; action.focus-workspace-down = [ ]; };
        "Mod+TouchpadScrollUp"   = { cooldown-ms = 150; action.focus-workspace-up = [ ]; };

        # // Usually scrolling up and down with Shift in applications results in
        # // horizontal scrolling; these binds replicate that.
        # Mod+Shift+WheelScrollDown      { focus-column-right; }
        # Mod+Shift+WheelScrollUp        { focus-column-left; }
        # Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        # Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }
        #
        # // Similarly, you can bind touchpad scroll "ticks".
        # // Touchpad scrolling is continuous, so for these binds it is split into
        # // discrete intervals.
        # // These binds are also affected by touchpad's natural-scroll, so these
        # // example binds are "inverted", since we have natural-scroll enabled for
        # // touchpads by default.
        # // Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
        # // Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }
        #
        # // You can refer to workspaces by index. However, keep in mind that
        # // niri is a dynamic workspace system, so these commands are kind of
        # // "best effort". Trying to refer to a workspace index bigger than
        # // the current workspace count will instead refer to the bottommost
        # // (empty) workspace.
        # //
        # // For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
        # // will all refer to the 3rd workspace.
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+0".action.focus-workspace = 10;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;
        "Mod+Shift+0".action.move-column-to-workspace = 10;

        # // If the window is alone, they will consume it into the nearby column to the side.
        # // If the window is already in a column, they will expel it out.
        "Mod+Comma".action.consume-or-expel-window-left = [ ];
        "Mod+Period".action.consume-or-expel-window-right = [ ];

        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+Shift+R".action.switch-preset-window-height = [ ];
        "Mod+Ctrl+R".action.reset-window-height = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+M".action.fullscreen-window = [ ];
        "Mod+C".action.center-column = [ ];

        "Mod+BracketLeft".action.set-column-width = "-10%";
        "Mod+BracketRight".action.set-column-width = "+10%";
        "Mod+Shift+BracketLeft".action.set-window-height = "-10%";
        "Mod+Shift+BracketRight".action.set-window-height = "+10%";

        # Move the focused window between the floating and the tiling layout.
        "Mod+Space".action.toggle-window-floating = [ ];

        "Print".action.screenshot = [ ];
        "Ctrl+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];

        # The quit action will show a confirmation dialog to avoid accidental exits.
        "Mod+Shift+E".action.quit = [ ];
        "Ctrl+Alt+Delete".action.quit = [ ];

        # Powers off the monitors. To turn them back on, do any input like
        # moving the mouse or pressing any other key.
        "Mod+Shift+P".action.power-off-monitors = [ ];
      };

      # recent-windows.binds = {
      #     "Alt+Tab".action.next-window = [ ];
      #     "Alt+Shift+Tab".action.previous-window = [ ];
      # };
    };
  };
}
