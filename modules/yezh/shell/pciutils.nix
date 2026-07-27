{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.shell.pciutils";

  options = { myconfig, ... }: {
    yezh.shell.pciutils.enable = delib.boolOption myconfig.user.shell.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      pciutils
    ];
  };
}
