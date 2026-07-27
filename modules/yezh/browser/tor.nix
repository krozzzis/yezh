{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.browser.tor";

  options = { myconfig, ... }: {
    yezh.browser.tor.enable = delib.boolOption myconfig.user.gui.enable;
    yezh.browser.tor.pkg = delib.packageOption (pkgs.tor-browser);
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      tor-browser
    ];
  };
}
