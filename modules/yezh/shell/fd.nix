{ delib, lib, pkgs, ... }:
delib.module {
  name = "yezh.shell.fd";

  options = { myconfig, ... }: {
    yezh.shell.fd.enable = delib.boolOption myconfig.user.shell.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      fd
    ];
  };
}
