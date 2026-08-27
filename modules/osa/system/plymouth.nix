{ delib, lib, pkgs, inputs, ... }:
delib.module {
  name = "osa.system.plymouth";

  options = { myconfig, ... }: {
    osa.system.plymouth.enable = delib.boolOption false;
    osa.system.plymouth.theme = lib.mkOption {
      type = lib.types.str;
      default = "material";
      description = "Plymouth theme name. Must exist in boot.plymouth.themePackages or the default plymouth package. OSA ships Material You 'material' matching DMS.";
    };
    osa.system.plymouth.logo = lib.mkOption {
      type = lib.types.path;
      default = ../../../assets/osa-logo-yellow.png;
      description = "Logo displayed by plymouth (PNG, 48x48 is GDM default but any size works). Yellow on transparent, 1/4 size for plymouth watermark.";
    };
  };

  nixos.ifEnabled = { cfg, myconfig, ... }: {
    boot.plymouth.enable = true;
    boot.plymouth.theme = lib.mkDefault cfg.theme;
    boot.plymouth.themePackages = [ inputs.plymouth-theme-material.packages.${pkgs.stdenv.hostPlatform.system}.plymouth-theme-material ];
    boot.plymouth.logo = lib.mkDefault cfg.logo;
    boot.plymouth.font = lib.mkDefault "${myconfig.user.fonts.regular.pkg}/share/fonts/truetype/InterVariable.ttf";

    # cryptsetup password prompt via systemd-ask-password goes through plymouth when initrd systemd is used
    boot.initrd.systemd.enable = lib.mkDefault true;

    # material.script — DMS-like: Inter, rounded 12, blur-like dark surface, primary bullets
    # We inline it via theme package above; for reference the script is:
    # Window.SetBackgroundTopColor(0.08, 0.08, 0.09); // #141218
    # Window.SetBackgroundBottomColor(0.11, 0.11, 0.12); // #1C1B1F
    # logo centered with fade, dialog box 520x320, lock+entry 360x56, bullets 14x14 primary #6750A4
  };
}
