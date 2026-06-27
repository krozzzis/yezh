{ delib, lib, ... }:
delib.module {
  name = "shell.fzf";

  options = { myconfig, ... }: {
    shell.fzf.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  home.ifEnabled = {
    programs.fzf.enable = true;
  };
}
