{ delib, lib, ... }:
delib.module {
  name = "de.niri";

  home.ifEnabled = {
    programs.niri.settings.layer-rules = [
      {
        matches = [
          { namespace = "^noctalia-overview"; }
        ];
        place-within-backdrop = true;
      }

      {
        matches = [
          { namespace = "^quickshell$"; }
        ];
        place-within-backdrop = true;
      }
    ];
  };
}
