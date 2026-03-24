{ delib, lib, pkgs, ... }:
delib.module {
  name = "user.fonts";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf

      twemoji-color-font

      inter
      jetbrains-mono

      nerd-fonts.jetbrains-mono
    ];

    fonts.fontconfig = {
      defaultFonts = {
        serif     = [ "Noto Serif" "Noto Serif CJK SC" ];
        sansSerif = [ "Inter" "Noto Sans CJK SC" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono CJK SC" ];
        emoji     = [ "Twemoji Mozilla" "Noto Color Emoji" ];
      };
    };
  };
}
