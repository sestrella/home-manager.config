let
  sources = import ./nix/sources.nix {};
  pkgs = import sources.nixpkgs {};
in pkgs.mkShell {
  name = "nix-home";
  buildInputs = [
    (import sources.home-manager { inherit pkgs; }).home-manager
    pkgs.niv
  ];
  shellHook = ''
    export NIX_PATH="nixpkgs=${sources.nixpkgs}"
  '';
}
