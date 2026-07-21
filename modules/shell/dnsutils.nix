{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.dnsutils";

  options = { myconfig, ... }: {
    shell.dnsutils.enable = delib.boolOption myconfig.shell.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      dnsutils
    ];
  };
}
