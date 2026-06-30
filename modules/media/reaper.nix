{ delib, lib, pkgs, ... }:
delib.module {
  name = "media.reaper";

  options = { myconfig, ... }: {
    media.reaper.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;
    };
    media.reaper.quantum = lib.mkOption {
      type = lib.types.int;
      default = 256;
      description = "JACK quantum (buffer size in frames) for Reaper";
    };
    media.reaper.rate = lib.mkOption {
      type = lib.types.int;
      default = 96000;
      description = "Sample rate for Reaper";
    };
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
