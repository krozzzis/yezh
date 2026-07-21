{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.prismlauncher";

  options = { myconfig, ... }: {
    apps.prismlauncher.enable = delib.boolOption myconfig.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
