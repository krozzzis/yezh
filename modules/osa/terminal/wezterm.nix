{ delib, pkgs, ... }:
delib.module {
  name = "osa.terminal.wezterm";

  options = { myconfig, ... }: {
    osa.terminal.wezterm.enable = delib.boolOption myconfig.user.gui.enable;
    osa.terminal.wezterm.pkg = delib.packageOption pkgs.wezterm;
  };

  # Look & feel is personal taste -- see modules/dotfiles/wezterm.nix in the
  # osa-user flake, which extends this same module by name.
  home.ifEnabled = { myconfig, ... }: {
    programs.wezterm = {
      enable = true;
      settings = {
        # Прозрачность берём из глобального ui.transparency, блюр — через Wayland ext-background-effect (niri его поддерживает).
        # wayland_window_background_blur=true + window_background_opacity<1 даёт размытый фон за терминалом.
        window_background_opacity = myconfig.user.ui.transparency;
        text_background_opacity = myconfig.user.ui.transparency;
        wayland_window_background_blur = true;
      };
    };
  };
}
