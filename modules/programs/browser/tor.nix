{ delib, pkgs, ... }:
delib.module {
  name = "programs.tor";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      tor-browser
    ];
  };
}
