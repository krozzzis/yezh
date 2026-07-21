{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.zsh";

  options = { myconfig, ... }: {
    shell.zsh.enable = delib.boolOption (myconfig.shell.enable && myconfig.shell.default != null
        && lib.getName myconfig.shell.zsh.pkg == lib.getName myconfig.shell.default.pkg);
    shell.zsh.pkg = delib.packageOption pkgs.zsh;
  };

  home.ifEnabled = { myconfig, ... }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;

      initContent = ''
        [[ -z $TMUX ]] || export TERM=screen-256color

        setopt auto_cd

        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' completer _complete _ignored

        bindkey '^[[1;5C' forward-word
        bindkey '^[[1;5D' backward-word
        bindkey '^[OC' forward-word
        bindkey '^[OD' backward-word
      '';
    };

    programs.fzf.enableZshIntegration = myconfig.shell.fzf.enable;
  };

  nixos.ifEnabled = { myconfig, ... }: let
    inherit (myconfig.constants) username;
  in {
    programs.zsh.enable = true;
  };
}

