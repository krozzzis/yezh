{ delib, ... }:
delib.module {
  name = "osa.system.unfree";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.nixpkgs.config.allowUnfree = true;
  home.ifEnabled.nixpkgs.config.allowUnfree = true;
}
