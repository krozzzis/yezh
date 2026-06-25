{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.prismlauncher";

  options = { myconfig, ... }: {
    apps.prismlauncher.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
