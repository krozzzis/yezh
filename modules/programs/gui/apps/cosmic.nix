{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.de.cosmic";

  options = { myconfig, ... }: {
    programs.gui.apps.cosmic = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      files = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Cosmic file manager";
      };
      reader = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Cosmic document reader";
      };
      calculator = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Cosmic calculator";
      };
      player = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Cosmic media player";
      };
      workspaces = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Cosmic workspaces epoch";
      };
    };
  };

  home.ifEnabled = { cfg, ... }: let
    packages = with pkgs; (
      (lib.optionals cfg.files [ cosmic-files ])
      ++ (lib.optionals cfg.reader [ cosmic-reader ])
      ++ (lib.optionals cfg.calculator [ cosmic-ext-calculator ])
      ++ (lib.optionals cfg.player [ cosmic-player ])
      ++ (lib.optionals cfg.workspaces [ cosmic-workspaces-epoch ])
    );
  in {
    home.packages = packages;
  };
}
