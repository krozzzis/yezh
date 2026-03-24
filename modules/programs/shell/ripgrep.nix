{ delib, ... }:
delib.module {
  name = "programs.ripgrep";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.ripgrep = {
      enable = true;
    };
  };
}
