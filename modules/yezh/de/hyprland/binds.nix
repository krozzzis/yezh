{ delib, lib, ... }:
let
  t = import ../../../../lib/shortcuts-translators.nix { inherit lib; };
in
delib.module {
  name = "yezh.de.hyprland";

  home.ifEnabled = { myconfig, ... }: {
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      bind =
        t.toHyprlandBindsList { inherit myconfig; }
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
              let ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  };
}
