{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.dnsutils";

  options = { myconfig, ... }: {
    shell.dnsutils.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      dnsutils
    ];
  };
}
