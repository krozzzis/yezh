# For osa/apps/walker.nix (elephant, walker) and osa/apps/winapps.nix (winapps).
{ ... }:
{
  flake-file.inputs = {
    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
