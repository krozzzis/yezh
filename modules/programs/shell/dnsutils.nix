{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.shell.dnsutils";

  options = { myconfig, ... }: {
    programs.shell.dnsutils.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.shell.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      dnsutils
    ];
  };
}
