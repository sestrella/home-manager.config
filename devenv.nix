{ pkgs, ... }:

{
  packages = [
    pkgs.swift-format
    pkgs.swiftpm
    pkgs.swiftpm2nix
  ];

  languages.swift.enable = true;

  git-hooks.hooks.shellcheck.enable = true;

  cachix.pull = [ "sestrella" ];

  outputs = import ./packages { inherit pkgs; };
}
