{ pkgs, home-manager }:

pkgs.mkShell {
  buildInputs = [
    home-manager
  ];
}
