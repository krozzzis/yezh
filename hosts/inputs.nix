# Host-generic: disko (partitioning, used by nixlaptop/eeepc disko.nix) and
# nixos-hardware (used by pi-backup's hardware.nix and default.nix).
{ ... }:
{
  flake-file.inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
