{ delib, lib, pkgs, ... }:
delib.module {
  name = "defaultApps";

  options = { myconfig, ... }: {
    terminal.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.terminal.wezterm.pkg; };
    };
    editor.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.editor.vim.pkg; };
    };
    browser.default = lib.mkOption {
      type = lib.types.attrs;
      default = if myconfig.browser.zenBrowser.enable or false then { pkg = myconfig.browser.zenBrowser.pkg; }
                else if myconfig.browser.firefox.enable or false then { pkg = myconfig.browser.firefox.pkg; }
                else { pkg = pkgs.firefox; };
    };
    fileManager.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = pkgs.nautilus; };
    };
    musicPlayer.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.media.vlc.pkg; };
    };
    videoPlayer.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.media.vlc.pkg; };
    };
  };

  nixos.always = { myconfig, ... }: {
    environment.variables = {
      EDITOR = lib.getName myconfig.editor.default.pkg;
      BROWSER = lib.getName myconfig.browser.default.pkg;
      TERMINAL = lib.getName myconfig.terminal.default.pkg;
    };

    xdg.mime.defaultApplications = {
      "inode/directory" = "${lib.getName myconfig.fileManager.default.pkg or pkgs.nautilus}.desktop";
      "text/plain" = "${lib.getName myconfig.editor.default.pkg}.desktop";
      "x-scheme-handler/http" = "${lib.getName myconfig.browser.default.pkg}.desktop";
      "x-scheme-handler/https" = "${lib.getName myconfig.browser.default.pkg}.desktop";
      "video/*" = "${lib.getName myconfig.videoPlayer.default.pkg}.desktop";
      "audio/*" = "${lib.getName myconfig.musicPlayer.default.pkg}.desktop";
    };
  };
}
