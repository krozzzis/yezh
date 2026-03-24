{ delib, pkgs, ... }:
delib.module {
  name = "programs.anytype";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      anytype
    ];
    nixpkgs.config.allowUnfree = true;
  };
}
