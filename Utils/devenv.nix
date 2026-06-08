{ pkgs, ... }:

{
  packages = [
    pkgs.swift-format
    pkgs.swiftPackages.swiftpm
  ];

  languages.swift = {
    enable = true;
    lsp.enable = true;
  };

  # stdenv = pkgs.stdenv.override {
  #   extraBuildInputs = [ ];
  # };

  # apple.sdk = null;
}
