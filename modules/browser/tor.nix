{ delib, lib, pkgs, ... }:
delib.module {
  name = "browser.tor";

  options = { myconfig, ... }: {
    browser.tor.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
    browser.tor.pkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.tor-browser;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      tor-browser
    ];
  };
}
