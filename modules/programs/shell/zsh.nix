{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.shell.zsh";

  options = { myconfig, ... }: {
    programs.shell.zsh.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.name == "zsh";
    };
  };

  home.ifEnabled = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;

      initContent = ''
        [[ -z $TMUX ]] || export TERM=screen-256color

        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' completer _complete _ignored
      '';
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  nixos.ifEnabled = { myconfig, ... }:
  let
    inherit (myconfig.constants) username;
  in
  {
    programs.zsh.enable = true;
  };

  nixos.always = { myconfig, ... }:
  let
    inherit (myconfig.constants) username;
  in
  {
    users.users.${username}.shell = lib.mkIf (myconfig.shell.name == "zsh") pkgs.zsh;
  };
}
