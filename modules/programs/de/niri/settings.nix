{ delib, host, ... }:
delib.module {
  name = "programs.niri";

  home.ifEnabled = {
    programs.niri.settings = {
      # -- Spawn at startup
      spawn-at-startup = [
        { argv = [ "xwayland-satellite" ]; }
        {
          # clear clipboard at niri start
          argv = [
            "rm"
            "'$XDG_CACHE_HOME/cliphist/db'"
          ];
        }
      ];

      # -- environment variables within niri
      environment = {
        DISPLAY = ":0";
        SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
        QT_QPA_PLATFORM = "wayland";
      };

      hotkey-overlay = {
        skip-at-startup = true;
        hide-not-bound = true;
      };

      # -- Misc settings
      prefer-no-csd = true; # omit client side window decorations
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      animations.enable = true;

      # -- Named workspaces
      workspaces."1" = {};
      workspaces."2" = {};
      workspaces."3" = {};
      workspaces."4" = {};
      workspaces."5" = {};
      workspaces."6" = {};
      workspaces."7" = {};
      workspaces."8" = {};
      workspaces."9" = {};
      workspaces."0" = {};
    };
  };
}
