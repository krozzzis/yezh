{ delib, pkgs, ... }:
delib.module {
  name = "user.dev";

  myconfig.ifEnabled = {
    user.dev.lsp."rust-analyzer" = {
      enable = true;
      package = pkgs.rust-analyzer;
      settings = {
        checkOnSave = true;
        check.command = "clippy";
      };
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      rust-analyzer
      rustc
      cargo
    ];
  };
}
