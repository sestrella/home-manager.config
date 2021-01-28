let
  sources = import ./nix/sources.nix;
  nixpkgs = sources.nixpkgs;
  home-manager = sources.home-manager;
  pkgs = import nixpkgs {};
in pkgs.mkShell {
  name = "nix-home";
  buildInputs = [
    (import home-manager { inherit pkgs; }).home-manager
  ];
  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${home-manager}"
  '';
}
