{ delib, ... }:
delib.module {
  name = "user.capsLockSwitchLayout";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.xserver.xkb.options = "grp:caps_toggle";
  };
}
