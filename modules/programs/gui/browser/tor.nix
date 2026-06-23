{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.browser.tor";

  options = { myconfig, ... }: {
    programs.gui.browser.tor.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.browser.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      tor-browser
    ];
  };
}
