{ delib, lib, ... }:
delib.module {
  name = "shell.yazi";

  options = { myconfig, ... }: {
    shell.yazi.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  home.ifEnabled = { myconfig, ... }: {
    programs.yazi = {
      enable = true;
      settings = {
        opener = {
          edit = [
            { run = "${lib.getName myconfig.editor.default.pkg} \"$@\""; block = true; desc = "Editor"; }
          ];
        };
      };
    };
  };
}
