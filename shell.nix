{ pkgs }:

pkgs.mkShell {
  buildInputs = [
    pkgs.home-manager
  ];
}
