{ delib, pkgs, inputs, ... }:
delib.module {
  name = "programs.zen-browser";

  options = delib.singleEnableOption false;

  home.always.imports = [ inputs.zen-browser.homeModules.default ];

  nixos.ifEnabled = {
    environment.sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
    };
  };

  home.ifEnabled = {
    programs.zen-browser = {
      enable = true;

      policies = let
          mkLockedAttrs = builtins.mapAttrs (_: value: {
            Value = value;
            Status = "locked";
          });
        in {

          Preferences = mkLockedAttrs {
            "widget.use-xdg-desktop-portal.file-picker" = 1;
          };
        };
    };

    # programs.zen-browser.profiles.default.extensions = {
    #   packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
    #     ublock-origin
    #   ];
    # };
  };
}
