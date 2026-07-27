{ delib, lib, pkgs, ... }:
delib.module {
  name = "user.defaultApps";

  options = { myconfig, ... }: {
    user.terminal.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.yezh.terminal.wezterm.pkg; };
    };
    user.editor.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.yezh.editor.vim.pkg; };
    };
    user.browser.default = lib.mkOption {
      type = lib.types.attrs;
      default = if myconfig.yezh.browser.zenBrowser.enable or false then { pkg = myconfig.yezh.browser.zenBrowser.pkg; }
                else if myconfig.yezh.browser.firefox.enable or false then { pkg = myconfig.yezh.browser.firefox.pkg; }
                else { pkg = pkgs.firefox; };
    };
    user.fileManager.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = pkgs.nautilus; };
    };
    user.musicPlayer.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.yezh.media.vlc.pkg; };
    };
    user.videoPlayer.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.yezh.media.vlc.pkg; };
    };
    user.imageViewer.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.yezh.apps.swayimg.pkg; };
    };
    user.pdfViewer.default = lib.mkOption {
      type = lib.types.attrs;
      default = { pkg = myconfig.yezh.apps.cosmic.reader.pkg; };
    };
  };

  nixos.always = { myconfig, ... }:
    let
      bin = pkg: pkg.meta.mainProgram or (lib.getName pkg);
    in
    {
      environment.variables = {
        EDITOR = bin myconfig.user.editor.default.pkg;
        BROWSER = bin myconfig.user.browser.default.pkg;
        TERMINAL = bin myconfig.user.terminal.default.pkg;
      };

      xdg.mime.defaultApplications = {
        "inode/directory" = "${bin (myconfig.user.fileManager.default.pkg or pkgs.nautilus)}.desktop";
        "text/plain" = "${bin myconfig.user.editor.default.pkg}.desktop";
        "x-scheme-handler/http" = "${bin myconfig.user.browser.default.pkg}.desktop";
        "x-scheme-handler/https" = "${bin myconfig.user.browser.default.pkg}.desktop";
        "video/*" = "${bin myconfig.user.videoPlayer.default.pkg}.desktop";
        "audio/*" = "${bin myconfig.user.musicPlayer.default.pkg}.desktop";
        "image/*" = "${bin myconfig.user.imageViewer.default.pkg}.desktop";
        "application/pdf" = "${bin myconfig.user.pdfViewer.default.pkg}.desktop";
      };
    };

  home.always = { myconfig, ... }:
    let
      bin = pkg: pkg.meta.mainProgram or (lib.getName pkg);
    in
    {
      home.sessionVariables = {
        EDITOR = bin myconfig.user.editor.default.pkg;
      };
    };
}
