{ delib, pkgs, ... }:
delib.module {
  name = "programs.git";

  options = delib.singleEnableOption true;

  home.ifEnabled = { myconfig, ... }: {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings.user.name = myconfig.constants.username;
      settings.user.email = myconfig.constants.useremail;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      git
    ];
  };
}
