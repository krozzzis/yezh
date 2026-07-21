{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.reaper";

  options = { myconfig, ... }: {
    media.reaper.enable = delib.boolOption myconfig.gui.enable;
    media.reaper.quantum = delib.description (delib.intOption 256) "JACK quantum (buffer size in frames) for Reaper";
    media.reaper.rate = delib.description (delib.intOption 96000) "Sample rate for Reaper";
  };

  home.ifEnabled = { cfg, ... }: {
    home.packages = [
      (pkgs.writeShellScriptBin "reaper" ''
        export PIPEWIRE_LATENCY="${toString cfg.quantum}/${toString cfg.rate}"
        exec ${pkgs.pipewire.jack}/bin/pw-jack ${pkgs.reaper}/bin/reaper "$@"
      '')
    ];
  };

  nixos.ifEnabled = { cfg, ... }: {
    services.pipewire.extraConfig.jack."10-reaper" = {
      "jack.rules" = [{
        matches = [
          { "client.name" = "REAPER"; }
          { "application.process.binary" = "reaper"; }
        ];
        actions = {
          "update-props" = {
            "node.latency" = "${toString cfg.quantum}/${toString cfg.rate}";
            "node.rate" = "1/${toString cfg.rate}";
            "node.quantum" = "${toString cfg.quantum}/${toString cfg.rate}";
            "node.lock-quantum" = true;
            "node.force-quantum" = cfg.quantum;
          };
        };
      }];
    };
  };
}
