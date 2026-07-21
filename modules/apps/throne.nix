{ delib, lib, pkgs, ... }:
delib.module {
  name = "apps.throne";

  options = { myconfig, ... }: {
    apps.throne = {
      enable = delib.boolOption myconfig.gui.enable;
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
