{ delib, lib, pkgs, ... }:
delib.module {
  name = "osa.system.plymouth";

  options = { myconfig, ... }: {
    osa.system.plymouth.enable = delib.boolOption false;
    osa.system.plymouth.theme = lib.mkOption {
      type = lib.types.str;
      default = "bgrt";
      description = "Plymouth theme name. Must exist in boot.plymouth.themePackages or the default plymouth package.";
    };
    osa.system.plymouth.logo = lib.mkOption {
      type = lib.types.path;
      default = ../shell/assets/osa-logo.png;
      description = "Logo displayed by plymouth (PNG, 48x48 is GDM default but any size works). Used for spinner/spinfinity/bgrt watermark.";
    };
  };

  nixos.ifEnabled = { cfg, ... }: {
    boot.plymouth.enable = true;
    boot.plymouth.theme = lib.mkDefault cfg.theme;
    boot.plymouth.logo = lib.mkDefault cfg.logo;
  };
}
