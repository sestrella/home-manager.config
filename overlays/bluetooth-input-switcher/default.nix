{
  stdenv,
  swift,
  swiftpm,
  swiftpm2nix,
}:

let
  generated = swiftpm2nix.helpers ./nix;
in
stdenv.mkDerivation rec {
  pname = "bluetooth-input-switcher";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [
    swift
    swiftpm
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
