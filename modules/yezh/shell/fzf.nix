{ delib, lib, ... }:
delib.module {
  name = "yezh.shell.fzf";

  options = { myconfig, ... }: {
    yezh.shell.fzf.enable = delib.boolOption false;
  };

  home.ifEnabled = {
    programs.fzf.enable = true;
  };
}
