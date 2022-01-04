{ pkgs, home-manager }:

pkgs.mkShell {
  name = "nix-home";
  buildInputs = [
    home-manager
  ];
}
