{ pkgs, ... }:

{
  packages = [
    # pkgs.swift-format
    # pkgs.swiftPackages.swiftpm
    pkgs.swiftpm2nix
  ];

  languages.swift.enable = true;

  outputs.default = import ./default.nix { inherit pkgs; };
}
