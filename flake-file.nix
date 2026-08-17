{ lib, ... }:
let
  flakeInputs = import ./lib/flake-inputs.nix { inherit lib; };
  moduleDirs = [ ./modules ];
in
{
  description = "OSA -- reusable denix module library for NixOS + home-manager. hosts/ and user identity live in separate flakes (osa-host, osa-user) that depend on this one.";

  imports = flakeInputs.importModules moduleDirs;

  # `write-flake` writes this exact evalModules shim into flake.nix for us.
  # Based on flake-file's built-in "flake-module" preset (no flake-parts),
  # extended to also expose two bits of flake-file's own machinery that the
  # "flake-module" preset alone drops (it only returns `config.outputs
  # inputs`): `nix run .#write-flake` to regenerate this file, and a
  # `nix flake check` that fails loudly if someone edits flake.nix by hand
  # or forgets to regenerate it after adding an `inputs.nix`.
  flake-file.outputs = ''
    inputs:
      let
        evaluated = inputs.nixpkgs.lib.evalModules {
          specialArgs = { inherit inputs; inherit (inputs) self; };
          modules = [ inputs.flake-file.flakeModules.flake ./flake-file.nix ];
        };
        base = evaluated.config.outputs inputs;
        system = "x86_64-linux";
        pkgs = import inputs.nixpkgs { inherit system; };
      in
      base // {
        packages = (base.packages or { }) // {
          ''${system} = (base.packages.''${system} or { }) // {
            write-flake = evaluated.config.flake-file.apps.write-flake pkgs;
          };
        };
        checks = (base.checks or { }) // {
          ''${system} = (base.checks.''${system} or { }) // {
            flake-file-in-sync = evaluated.config.flake-file.check-flake-file pkgs;
          };
        };
      }
  '';

  # Core, foundational inputs every module effectively depends on
  # transitively (nixpkgs/home-manager/denix), plus flake-file itself.
  # Everything else lives in a sibling `inputs.nix` next to whichever
  # module(s) actually reference `inputs.<name>` -- see ./lib/flake-inputs.nix.
  #
  # Downstream flakes (osa-user, osa-host) declare the SAME core inputs
  # themselves (chicken-and-egg-exempt bootstrap set) and pull in the rest
  # by running the same collectInputModules scan over `${inputs.osa}/modules`.
  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    flake-file.url = "github:vic/flake-file";

    # Not currently referenced by any module (niri-pkgs replaced niri; no
    # module reaches for noctalia/nixGL directly) -- kept declared rather
    # than silently dropped, since removing them wasn't part of this
    # migration. Worth a follow-up: confirm still wanted, or delete.
    niri = {
      url = "github:sodiboo/niri-flake/very-refactor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # This flake is a module library, not a host builder -- hosts/ moved to
  # osa-host, which is what actually runs denix.lib.configurations to
  # produce nixosConfigurations. Nothing here needs `inputs` at eval time,
  # so there's no bootstrap chicken-and-egg like flake-file.nix's own
  # `outputs` had to work around.
  outputs = _inputs: { };
}
