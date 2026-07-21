{ delib, lib, pkgs, ... }:
delib.module {
  name = "shell.git";

  options = { myconfig, ... }: {
    shell.git.enable = delib.boolOption myconfig.shell.enable;
  };

  home.ifEnabled = { myconfig, ... }: {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings.user.name = myconfig.constants.username;
      settings.user.email = myconfig.constants.useremail;
      settings.core.editor = myconfig.editor.default.pkg.meta.mainProgram or (lib.getName myconfig.editor.default.pkg);
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      git
    ];
  };
}
