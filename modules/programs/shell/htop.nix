{ delib, ... }:
delib.module {
  name = "programs.htop";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.htop = {
      enable = true;
    };
  };
}
