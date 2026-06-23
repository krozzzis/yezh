{ delib, lib, pkgs, inputs, ... }:
delib.module {
  name = "programs.gui.browser.zen-browser";

  options = { myconfig, ... }: {
    programs.gui.browser.zen-browser.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.browser.enable;
    };
  };

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
