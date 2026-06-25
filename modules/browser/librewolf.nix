{ delib, lib, pkgs, ... }:
delib.module {
  name = "browser.librewolf";

  options = { myconfig, ... }: {
    browser.librewolf.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
    browser.librewolf.pkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.librewolf;
    };
  };

  home.ifEnabled = {
    programs.librewolf = {
      enable = true;
    };
  };
}
