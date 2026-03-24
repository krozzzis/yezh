{ delib, ... }:
delib.module {
  name = "user.caps-lock-switch-layout";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.xserver.xkb.options = "grp:caps_toggle";
  };
}
