{ pkgs, ... }:

{
  packages = [
    pkgs.swiftpm
    pkgs.swiftpm2nix
  ];

  languages.swift.enable = true;

  git-hooks.hooks.shellcheck.enable = true;

  outputs = import ./packages { inherit pkgs; };

  cachix.pull = [ "sestrella" ];
}
