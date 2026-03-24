{ delib, pkgs, ... }:
delib.module {
  name = "programs.audacity";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
