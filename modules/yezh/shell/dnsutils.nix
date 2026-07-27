{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.shell.dnsutils";

  options = { myconfig, ... }: {
    yezh.shell.dnsutils.enable = delib.boolOption myconfig.user.shell.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      dnsutils
    ];
  };
}
