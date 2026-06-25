{ delib, pkgs, ... }:
delib.module {
  name = "network.yggdrasil";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services.yggdrasil.enable = true;
  };
}
