{ delib, lib, pkgs, ... }:
delib.module {
  name = "ai.antigravity";

  options = { myconfig, ... }: {
    ai.antigravity.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      antigravity-fhs
    ];
  };
}
