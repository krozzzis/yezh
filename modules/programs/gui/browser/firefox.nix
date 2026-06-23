{ delib, lib, ... }:
delib.module {
  name = "programs.gui.browser.firefox";

  options = { myconfig, ... }: {
    programs.gui.browser.firefox.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.browser.enable;
    };
  };

  home.ifEnabled = {
    programs.firefox = {
      enable = true;
    };
  };
}
