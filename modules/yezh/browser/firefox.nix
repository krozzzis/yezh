{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.browser.firefox";

  options = { myconfig, ... }: {
    yezh.browser.firefox.enable = delib.boolOption myconfig.user.gui.enable;
    yezh.browser.firefox.pkg = delib.packageOption pkgs.firefox;
  };

  home.ifEnabled = {
    programs.firefox = {
      enable = true;
    };
  };
}
