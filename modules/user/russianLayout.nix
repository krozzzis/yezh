{ delib, ... }:
delib.module {
  name = "user.russianLayout";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.xserver.xkb.layout = "us,ru";
  };
}
