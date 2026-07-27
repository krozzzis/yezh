{ delib, lib, inputs, pkgs, ... }:
delib.module {
  name = "yezh.editor.nixvim";

  options = { myconfig, ... }: {
    yezh.editor.nixvim.enable = delib.boolOption false;

    yezh.editor.nixvim.pkg = delib.packageOption pkgs.neovim;
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
