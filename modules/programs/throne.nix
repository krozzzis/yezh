{ delib, pkgs, ... }:
delib.module {
  name = "programs.throne";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    programs.throne = {
      enable = true;
      tunMode.enable = true;
    };
  };
}
