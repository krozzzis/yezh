{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.download";

  options = { myconfig, ... }: {
    shell.download.enable = delib.boolOption myconfig.shell.enable;
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      wget
      curl
      rsync
    ];
  };
}
