{ lib, ... }:
let
  flakeInputs = import ./lib/flake-inputs.nix { inherit lib; };
  moduleDirs = [
    ./hosts
    ./modules
    ./rices
  ];

  realOutputs =
    { denix, ... }@inputs:
    let
      lib = inputs.nixpkgs.lib;

      mkConfigurations =
        moduleSystem:
        denix.lib.configurations {
          inherit moduleSystem;
          homeManagerUser = "krozzzis";

          paths = moduleDirs;
          # inputs.nix siblings are for flake-file (see ./lib/flake-inputs.nix),
          # not denix modules -- keep denix from tripping over them.
          exclude = flakeInputs.findPaths moduleDirs;

          extensions = with denix.lib.extensions; [
            args
            (base.withConfig {
              args.enable = true;
            })
          ];

          specialArgs = {
            inherit inputs;
          };
        };

      nixosConfigurationsBase = mkConfigurations "nixos";

      # A host+rice combination gets an offline installer ISO iff it's
      # partitioned via disko and targets a platform that actually boots
      # from an ISO (x86_64/i686 BIOS+UEFI machines) — e.g. pi-backup's
      # aarch64 SD-card image is a self-contained flashable image already
      # and has no `disko.devices` at all, so it's skipped automatically.
      isInstallable =
        _name: cfg:
        let
          system = cfg.config.nixpkgs.hostPlatform.system;
        in
        (system == "x86_64-linux" || system == "i686-linux")
        && (cfg.config ? disko)
        && cfg.config.disko.devices.disk != { };

      mkInstaller = import ./lib/installer.nix { inherit inputs; };

      installableTargets = lib.filterAttrs isInstallable nixosConfigurationsBase;

      installerConfigurations = lib.mapAttrs' (
        name: target: lib.nameValuePair "${name}-installer" (mkInstaller { targetName = name; inherit target; })
      ) installableTargets;

      installerPackages = lib.foldl' (
        acc: name:
        let
          target = installableTargets.${name};
          system = target.config.nixpkgs.hostPlatform.system;
        in
        lib.recursiveUpdate acc {
          ${system}."${name}-installer" = installerConfigurations."${name}-installer".config.system.build.isoImage;
        }
      ) { } (builtins.attrNames installableTargets);
    in
    {
      nixosConfigurations = nixosConfigurationsBase // installerConfigurations;
      homeConfigurations = mkConfigurations "home";
      packages = installerPackages;
    };
in
{
  description = "An OSA operating system. With Denix";

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

  outputs = realOutputs;
}
