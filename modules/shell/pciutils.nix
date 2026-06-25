{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.pciutils";

  options = { myconfig, ... }: {
    shell.pciutils.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      pciutils
    ];
  };
}
