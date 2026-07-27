{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.ai.antigravity";

  options = { myconfig, ... }: {
    yezh.ai.antigravity.enable = delib.boolOption myconfig.user.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      antigravity-fhs
    ];
  };
}
