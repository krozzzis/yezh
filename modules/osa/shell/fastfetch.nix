{ delib, ... }:
delib.module {
  name = "osa.shell.fastfetch";

  options = { myconfig, ... }: {
    osa.shell.fastfetch.enable = delib.boolOption myconfig.user.shell.enable;
  };

  home.ifEnabled = {
    programs.fastfetch = {
      enable = true;
      settings.display.showLogo = true;
    };
  };
}
