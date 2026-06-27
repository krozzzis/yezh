{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.fd";

  options = { myconfig, ... }: {
    shell.fd.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      fd
    ];
  };
}
