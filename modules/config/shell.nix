{ delib, lib, ... }:

delib.module {
  name = "shell";

  options = { myconfig, ... }: {
    shell.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable shell utilities (fish, eza, yazi, vim, etc.)";
    };
  };
}
