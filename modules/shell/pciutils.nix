{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.pciutils";

  options = { myconfig, ... }: {
    shell.pciutils.enable = delib.boolOption myconfig.shell.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      pciutils
    ];
  };
}
