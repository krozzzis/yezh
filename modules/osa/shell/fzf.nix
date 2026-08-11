{ delib, lib, ... }:
delib.module {
  name = "osa.shell.fzf";

  options = { myconfig, ... }: {
    osa.shell.fzf.enable = delib.boolOption false;
  };

  home.ifEnabled = {
    programs.fzf.enable = true;
  };
}
