{ delib, lib, ... }:
let
  t = import ../../../../lib/shortcuts-translators.nix { inherit lib; };
in
delib.module {
  name = "yezh.de.niri";

  home.ifEnabled = { myconfig, ... }: {
    programs.niri.settings.binds = t.toNiriBinds { inherit myconfig; };
  };
}
