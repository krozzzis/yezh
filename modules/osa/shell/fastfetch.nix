{ delib, ... }:
delib.module {
  name = "osa.shell.fastfetch";

  options = { myconfig, ... }: {
    osa.shell.fastfetch.enable = delib.boolOption myconfig.user.shell.enable;
  };

  home.ifEnabled = {
    programs.fastfetch = {
      enable = true;
      settings.logo = {
        # Rendered through fastfetch's built-in chafa integration, i.e. the
        # OSA wasp logo (assets/osa-logo.png) run through an ASCII/block art
        # generator instead of being an authored ASCII-art string.
        type = "chafa";
        source = ./assets/osa-logo.png;
        padding.top = 2;
      };
    };
  };
}
