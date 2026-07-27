{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.shell.download";

  options = { myconfig, ... }: {
    yezh.shell.download.enable = delib.boolOption myconfig.user.shell.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      wget
      curl
      rsync
    ];
  };
}
