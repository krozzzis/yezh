{ delib, ... }:
delib.module {
  name = "osa.system.direnv";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.programs.direnv.enable = true;
}
