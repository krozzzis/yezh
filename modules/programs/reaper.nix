{ delib, pkgs, ... }:
delib.module {
  name = "programs.reaper";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      reaper
    ];
  };
}
