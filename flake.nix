{
  description = "An OSA operating system. With Denix";

  inputs = {
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

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
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

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake/very-refactor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-pkgs = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    ntfsplus = {
      url = "github:cmspam/ntfsplus-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { denix, ... }@inputs:
    let
      lib = inputs.nixpkgs.lib;

      mkConfigurations =
        moduleSystem:
        denix.lib.configurations {
          inherit moduleSystem;
          homeManagerUser = "krozzzis";

          paths = [
            ./hosts
            ./modules
            ./rices
          ];

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
}
