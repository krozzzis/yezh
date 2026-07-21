{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "apps.wireshark";

  options = { myconfig, ... }: {
    apps.wireshark.enable = delib.boolOption myconfig.gui.enable;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      wireshark
    ];
  };

  nixos.ifEnabled = { myconfig, ... }: {
    programs.wireshark.enable = true;
    users.users.${myconfig.constants.username}.extraGroups = [ "wireshark" ];
  };
}
