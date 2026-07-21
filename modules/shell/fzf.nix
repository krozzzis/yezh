{ delib, lib, ... }:
delib.module {
  name = "shell.fzf";

  options = { myconfig, ... }: {
    shell.fzf.enable = delib.boolOption false;
  };

  home.ifEnabled = {
    programs.fzf.enable = true;
  };
}
