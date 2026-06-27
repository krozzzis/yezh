{ delib, lib, inputs, pkgs, ... }:
delib.module {
  name = "editor.nixvim";

  options = { myconfig, ... }: {
    editor.nixvim.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    editor.nixvim.pkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.neovim;
    };
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
