{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.ai.antigravity";

  options = { myconfig, ... }: {
    programs.gui.ai.antigravity.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.ai.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      antigravity-fhs
    ];
  };
}
