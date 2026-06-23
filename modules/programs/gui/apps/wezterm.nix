{ delib, lib, ... }:
delib.module {
  name = "programs.gui.apps.wezterm";

  options = { myconfig, ... }: {
    programs.gui.apps.wezterm.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.apps.enable;
    };
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
