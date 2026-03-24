{ delib, pkgs, ... }:
delib.module {
  name = "programs.ai.antigravity";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      antigravity-fhs
    ];
  };
}
