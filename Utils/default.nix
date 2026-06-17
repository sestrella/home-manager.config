{
  pkgs ? import <nixpkgs> { },
}:

let
  generated = pkgs.swiftpm2nix.helpers ./nix;
in
pkgs.stdenv.mkDerivation rec {
  pname = "Utils";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [
    pkgs.swift
    pkgs.swiftpm
  ];

  configurePhase = ''
    runHook preConfigure

    ${generated.configure}

    runHook postConfigure
  '';

  installPhase = ''
    runHook preInstall

    binPath="$(swiftpmBinPath)"
    mkdir -p $out/bin
    cp $binPath/${pname} $out/bin/

    runHook postInstall
  '';
}
