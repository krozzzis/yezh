{ delib, pkgs, ... }:
delib.module {
  name = "dev";

  myconfig.ifEnabled = {
    dev.lsp."rust-analyzer" = {
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
