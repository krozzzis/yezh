# For osa/de/caelestia.nix.
{ ... }:
{
  flake-file.inputs.caelestia-shell = {
    url = "github:caelestia-dots/shell";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
