{ delib, lib, pkgs, ... }:
delib.module {
  name = "browser.firefox";

  options = { myconfig, ... }: {
    browser.firefox.enable = delib.boolOption myconfig.gui.enable;
    browser.firefox.pkg = delib.packageOption pkgs.firefox;
  };

  home.ifEnabled = {
    programs.firefox = {
      enable = true;
    };
  };
}
