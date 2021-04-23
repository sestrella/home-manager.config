let
  sources = import ./nix/sources.nix {};
  pkgs = import sources.nixpkgs {};
in pkgs.mkShell {
  buildInputs = [
    (import sources.home-manager { inherit pkgs; }).home-manager
    (import sources.niv {}).niv
  ];
  shellHook = ''
    export NIX_PATH="home-manager=${sources.home-manager}:nixpkgs=${sources.nixpkgs}"
  '';
}
