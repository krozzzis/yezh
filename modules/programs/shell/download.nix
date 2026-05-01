{ delib, ... }:
delib.module {
  name = "programs.download";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      wget
      curl
      rsync
    ];
  };
}
