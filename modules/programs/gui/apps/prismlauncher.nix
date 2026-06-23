{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.apps.prismlauncher";

  options = { myconfig, ... }: {
    programs.gui.apps.prismlauncher.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.apps.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
