let
  sources = import ./sources.nix;
in {
  home-manager = import sources.home-manager {};
  niv = import sources.niv {};
  nixpkgs = import sources.nixpkgs {};
}
