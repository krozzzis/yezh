{ delib, ... }:
delib.module {
  name = "yezh.system.unfree";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.nixpkgs.config.allowUnfree = true;
  home.ifEnabled.nixpkgs.config.allowUnfree = true;
}
