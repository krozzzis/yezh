{ delib, lib, ... }:
delib.module {
  name = "de.hyprland";

  home.ifEnabled = { myconfig, ... }: {
    wayland.windowManager.hyprland = {
      settings = {
        "$mod" = "SUPER";
        bind =
          [
            "$mod, F, exec, ${lib.getName myconfig.browser.default.pkg}"
            "$mod, Return, exec, ${lib.getName myconfig.terminal.default.pkg}"
            ", Print, exec, grimblast copy area"
          ]
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
  };
}
