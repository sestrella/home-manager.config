let
  sources = import ./nix/sources.nix;
  home-manager = sources.home-manager;
  nixpkgs = sources.nixpkgs;
  pkgs = import nixpkgs {};
in pkgs.mkShell {
  name = "nix-home";
  buildInputs = [
    (import home-manager { inherit pkgs; }).home-manager
  ];
  shellHook = ''
    export NIX_PATH="home-manager=${home-manager}:nixpkgs=${nixpkgs}"
    export HOME_MANAGER_CONFIG="./home.nix"
  '';
}
