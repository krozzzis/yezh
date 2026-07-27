{ delib, ... }:
delib.module {
  name = "yezh.system.direnv";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.programs.direnv.enable = true;
}
