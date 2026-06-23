{ delib, pkgs, ... }:
delib.module {
  name = "programs.network.yggdrasil";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services.yggdrasil.enable = true;
  };
}
