{ delib, pkgs, ... }:
delib.module {
  name = "programs.yggdrasil";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.yggdrasil.enable = true;
  };
}
