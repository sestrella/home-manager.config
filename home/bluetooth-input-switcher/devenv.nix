{ pkgs, ... }:

{
  packages = [
    pkgs.swiftpm
    pkgs.swiftpm2nix
  ];

  languages.swift.enable = true;

  outputs.default = import ./package.nix { inherit pkgs; };
}
