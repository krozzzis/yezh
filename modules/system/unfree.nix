{ delib, ... }:
delib.module {
  name = "system.unfree";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.nixpkgs.config.allowUnfree = true;
}
