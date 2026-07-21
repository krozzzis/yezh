{ delib, lib, pkgs, ... }:
delib.module {
  name = "browser.tor";

  options = { myconfig, ... }: {
    browser.tor.enable = delib.boolOption myconfig.gui.enable;
    browser.tor.pkg = delib.packageOption (pkgs.tor-browser);
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      tor-browser
    ];
  };
}
