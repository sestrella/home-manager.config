{ pkgs }:

pkgs.mkShell {
  buildInputs = [
    pkgs.home-manager
    pkgs.nixpkgs-fmt
  ];
}
