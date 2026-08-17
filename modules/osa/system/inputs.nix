# For osa/system/ntfs.nix (ntfsplus) and osa/system/sddm.nix (silentSDDM).
{ ... }:
{
  flake-file.inputs = {
    ntfsplus = {
      url = "github:cmspam/ntfsplus-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
