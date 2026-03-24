{ delib, pkgs, ... }:

delib.module {
  name = "shell.uutils";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      (lib.hiPrio uutils-coreutils-noprefix)
    ];

    environment.shellInit = ''
      export PATH="${pkgs.uutils-coreutils-noprefix}/bin''${PATH:+:}$PATH"
    '';
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      (lib.hiPrio uutils-coreutils-noprefix)
    ];
  };
}
