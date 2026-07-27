{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.apps.prismlauncher";

  options = { myconfig, ... }: {
    yezh.apps.prismlauncher.enable = delib.boolOption myconfig.user.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
