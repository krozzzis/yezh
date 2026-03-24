{ delib, pkgs, ... }:
delib.module {
  name = "programs.zed";

  options = delib.singleEnableOption false;

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
