{ delib, ... }:
delib.module {
  # ls replacement
  name = "programs.eza";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.eza = {
      enable = true;
    };

    home = {
      shellAliases = {
        l = "eza -la --icons --no-permissions --no-user";
        ls = "eza --icons";
        la = "eza -la --icons";
        ll = "eza -l --icons";
        lt = "eza -l --tree";
      };
    };
  };
}
