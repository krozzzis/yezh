{ delib, lib, pkgs, ... }:
delib.module {
  name = "browser.firefox";

  options = { myconfig, ... }: {
    browser.firefox.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
    browser.firefox.pkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.firefox;
    };
  };

  home.ifEnabled = {
    programs.firefox = {
      enable = true;
    };
  };
}
