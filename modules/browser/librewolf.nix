{ delib, lib, pkgs, ... }:
delib.module {
  name = "browser.librewolf";

  options = { myconfig, ... }: {
    browser.librewolf.enable = delib.boolOption myconfig.gui.enable;
    browser.librewolf.pkg = delib.packageOption pkgs.librewolf;
  };

  home.ifEnabled = {
    programs.librewolf = {
      enable = true;
    };
  };
}
