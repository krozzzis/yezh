{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.terminal.wezterm";

  options = { myconfig, ... }: {
    yezh.terminal.wezterm.enable = delib.boolOption myconfig.user.gui.enable;
    yezh.terminal.wezterm.pkg = delib.packageOption pkgs.wezterm;
  };

  home.ifEnabled = {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require 'wezterm'
        local config = wezterm.config_builder()

        config.font = wezterm.font 'JetBrains Mono'
        config.hide_tab_bar_if_only_one_tab = true

        config.colors = {
            background = 'rgba(0,0,0,0.7)',
        }
        return config
      '';
    };
  };
}
