{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.browser.librewolf";

  options = { myconfig, ... }: {
    yezh.browser.librewolf.enable = delib.boolOption myconfig.user.gui.enable;
    yezh.browser.librewolf.pkg = delib.packageOption pkgs.librewolf;
  };

  home.ifEnabled = {
    programs.librewolf = {
      enable = true;
    };
  };
}
