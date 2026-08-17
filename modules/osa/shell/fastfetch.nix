{ delib, lib, pkgs, ... }:
delib.module {
  name = "osa.shell.fastfetch";

  options = { myconfig, ... }: {
    osa.shell.fastfetch.enable = delib.boolOption myconfig.user.shell.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      fastfetch
    ];
  };
}
