{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.throne";

  options = { myconfig, ... }: {
    apps.throne = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = myconfig.gui.enable;
      };
      tunMode = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable TUN mode for VPN";
      };
    };
  };

  nixos.ifEnabled = { cfg, ... }: {
    programs.throne = {
      enable = true;
      tunMode.enable = cfg.tunMode;
    };
  };
}
