{ delib, lib, inputs, pkgs, ... }:
delib.module {
  name = "osa.editor.nixvim";

  options = { myconfig, ... }: {
    osa.editor.nixvim.enable = delib.boolOption false;

    osa.editor.nixvim.pkg = delib.packageOption pkgs.neovim;
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
