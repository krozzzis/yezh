{ delib, lib, ... }:
delib.module {
  name = "programs.gui.browser.librewolf";

  options = { myconfig, ... }: {
    programs.gui.browser.librewolf.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.browser.enable;
    };
  };

  home.ifEnabled = {
    programs.librewolf = {
      enable = true;
    };
  };
}
