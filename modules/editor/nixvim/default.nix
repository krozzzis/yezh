{ delib, lib, inputs, pkgs, ... }:
delib.module {
  name = "editor.nixvim";

  options = { myconfig, ... }: {
    editor.nixvim.enable = delib.boolOption false;

    editor.nixvim.pkg = delib.packageOption pkgs.neovim;
  };

  home.always.imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  home.ifEnabled = {
    programs.nixvim = {
      enable = true;
      nixpkgs.source = inputs.nixpkgs;
    };
  };
}
