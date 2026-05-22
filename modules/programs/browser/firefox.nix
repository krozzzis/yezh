{ delib, ... }:
delib.module {
  name = "programs.firefox";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.firefox = {
      enable = true;
    };
  };
}
