{ delib, pkgs, ... }:
delib.module {
  name = "yezh.network.yggdrasil";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services.yggdrasil.enable = true;
  };
}
