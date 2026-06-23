{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.gui.dev.zed";

  options = { myconfig, ... }: {
    programs.gui.dev.zed.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.dev.enable;
    };
  };

  home.ifEnabled = {
    programs.zed-editor = {
      enable = true;

      userSettings = {
        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        title_bar = {
          show_sign_in = false;
          show_branch_icon = false;
        };
      };
    };
  };
}
