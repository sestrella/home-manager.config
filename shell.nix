{ home-manager, pkgs }:

pkgs.mkShell {
  name = "nix-home";
  buildInputs = [
    home-manager
  ];
}
