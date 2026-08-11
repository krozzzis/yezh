{ delib, lib, pkgs, ... }:
delib.module {
  name = "osa.shell.git";

  options = { myconfig, ... }: {
    osa.shell.git.enable = delib.boolOption myconfig.user.shell.enable;
  };

  home.ifEnabled = { myconfig, ... }: {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings.user.name = myconfig.user.constants.username;
      settings.user.email = myconfig.user.constants.useremail;
      settings.core.editor = myconfig.user.editor.default.pkg.meta.mainProgram or (lib.getName myconfig.user.editor.default.pkg);
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      git
    ];
  };
}
