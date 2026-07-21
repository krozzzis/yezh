{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "apps.gparted";

  options = { myconfig, ... }: {
    apps.gparted.enable = delib.boolOption myconfig.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      (writeShellScriptBin "gparted" ''
        exec pkexec "${pkgs.coreutils}/bin/env" \
          DISPLAY="''${DISPLAY:-:0}" \
          XAUTHORITY="''${XAUTHORITY:-$HOME/.Xauthority}" \
          "${pkgs.gparted}/bin/gparted" "$@"
      '')
    ];
  };
}
