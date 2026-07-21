{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "shell.yazi";

  options = { myconfig, ... }: {
    shell.yazi.enable = delib.boolOption myconfig.shell.enable;
  };

  home.ifEnabled = { myconfig, ... }: {
    home.packages = with pkgs; [
      exiftool
      mediainfo
      poppler
      chafa
      ffmpeg
      ripgrep
    ];

    programs.yazi = {
      enable = true;
      settings = {
        opener = {
          edit = [
            {
              run = ''${myconfig.editor.default.pkg.meta.mainProgram or (lib.getName myconfig.editor.default.pkg)} "$@"'';
              block = true;
              desc = "Editor";
            }
          ];
        };
      };
    };
  };
}
