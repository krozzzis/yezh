{ delib, pkgs, ... }:
delib.module {
  name = "osa.terminal.wezterm";

  options = { myconfig, ... }: {
    osa.terminal.wezterm.enable = delib.boolOption myconfig.user.gui.enable;
    osa.terminal.wezterm.pkg = delib.packageOption pkgs.wezterm;
  };

  # Look & feel is personal taste -- see modules/dotfiles/wezterm.nix in the
  # osa-user flake, which extends this same module by name.
  home.ifEnabled = {
    programs.wezterm.enable = true;
  };
}
