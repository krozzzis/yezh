{ delib, ... }:
delib.module {
  name = "system.direnv";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.programs.direnv.enable = true;
}
