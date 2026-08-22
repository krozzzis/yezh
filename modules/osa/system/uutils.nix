{
  delib,
  lib,
  pkgs,
  ...
}:

delib.module {
  name = "osa.system.uutils";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      (lib.hiPrio uutils-coreutils-noprefix)
      uutils-findutils
      uutils-diffutils
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
