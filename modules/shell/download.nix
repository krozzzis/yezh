{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.download";

  options = { myconfig, ... }: {
    shell.download.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      wget
      curl
      rsync
    ];
  };
}
