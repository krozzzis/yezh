{ delib, ... }:
delib.module {
  name = "system.nix-features";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
