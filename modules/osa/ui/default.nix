{ delib, lib, ... }:
delib.module {
  name = "osa.ui";

  options = { myconfig, ... }: {
    osa.ui.transparency = lib.mkOption {
      type = lib.types.float;
      default = myconfig.user.ui.transparency;
      defaultText = lib.literalExpression "myconfig.user.ui.transparency";
      description = "Global UI transparency (0.0 fully transparent, 1.0 fully opaque) for all OSA apps. Defaults to user.ui.transparency (0.9 = 90%).";
    };
  };

  # Глобальные шрифты: ставим пакеты из user.fonts в систему,
  # иначе fallback-шрифт выглядит неестественно большим (как в walker после слома темы).
  nixos.always = { myconfig, ... }: {
    fonts.packages = [
      myconfig.user.fonts.regular.pkg
      myconfig.user.fonts.monospace.pkg
    ];
  };
}
