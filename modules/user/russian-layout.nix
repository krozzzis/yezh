{ delib, ... }:
delib.module {
  name = "user.russian-layout";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.xserver.xkb.layout = "us,ru";
  };
}
