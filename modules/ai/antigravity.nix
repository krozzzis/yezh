{ delib, lib, pkgs, ... }:
delib.module {
  name = "ai.antigravity";

  options = { myconfig, ... }: {
    ai.antigravity.enable = delib.boolOption myconfig.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      antigravity-fhs
    ];
  };
}
