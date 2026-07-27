{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.apps.throne";

  options = { myconfig, ... }: {
    yezh.apps.throne = {
      enable = delib.boolOption myconfig.user.gui.enable;
      tunMode = delib.description (delib.boolOption true) "Enable TUN mode for VPN";
    };
  };

  nixos.ifEnabled = { cfg, ... }: {
    programs.throne = {
      enable = true;
      tunMode.enable = cfg.tunMode;
    };
  };
}
