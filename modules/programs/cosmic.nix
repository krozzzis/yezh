{ delib, pkgs, ... }:
delib.module {
  name = "programs.cosmic";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      cosmic-files
      cosmic-reader
      cosmic-ext-calculator
      cosmic-player
      cosmic-workspaces-epoch
    ];
  };
}
