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

  nixos.always = { myconfig, ... }:
    let
      bin = pkg: pkg.meta.mainProgram or (lib.getName pkg);
    in
    {
      environment.variables = {
        EDITOR = bin myconfig.editor.default.pkg;
        BROWSER = bin myconfig.browser.default.pkg;
        TERMINAL = bin myconfig.terminal.default.pkg;
      };

      xdg.mime.defaultApplications = {
        "inode/directory" = "${bin (myconfig.fileManager.default.pkg or pkgs.nautilus)}.desktop";
        "text/plain" = "${bin myconfig.editor.default.pkg}.desktop";
        "x-scheme-handler/http" = "${bin myconfig.browser.default.pkg}.desktop";
        "x-scheme-handler/https" = "${bin myconfig.browser.default.pkg}.desktop";
        "video/*" = "${bin myconfig.videoPlayer.default.pkg}.desktop";
        "audio/*" = "${bin myconfig.musicPlayer.default.pkg}.desktop";
      };
    };

  home.always = { myconfig, ... }:
    let
      bin = pkg: pkg.meta.mainProgram or (lib.getName pkg);
    in
    {
      home.sessionVariables = {
        EDITOR = bin myconfig.editor.default.pkg;
      };
    };
}
