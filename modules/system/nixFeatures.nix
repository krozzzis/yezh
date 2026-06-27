{ delib, ... }:
delib.module {
  name = "system.nixFeatures";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
