{ delib, ... }:
delib.module {
  name = "programs.niri";

  home.ifEnabled = {
    programs.niri.settings.layer-rules = [
      {
        matches = [
          { namespace = "^noctalia-overview"; }
        ];
        place-within-backdrop = true;
      }
    ];
  };
}
