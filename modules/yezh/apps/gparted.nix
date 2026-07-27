{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "yezh.apps.gparted";

  options = { myconfig, ... }: {
    yezh.apps.gparted.enable = delib.boolOption myconfig.user.gui.enable;
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
