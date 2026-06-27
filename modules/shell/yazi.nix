{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "shell.yazi";

  options = { myconfig, ... }: {
    shell.yazi.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
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
