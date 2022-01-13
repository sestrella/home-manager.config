{
  description = "A Home Manager flake";

  inputs = {
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, home-manager, nixpkgs }:
    let
      system = "x86_64-darwin";
    in {
      devShell.${system} = import ./shell.nix {
        home-manager = home-manager.defaultPackage.${system};
        pkgs = nixpkgs.legacyPackages.${system};
      };
      packages.${system} = {
        homeConfigurations =
          let
            mkconfig = username:
              home-manager.lib.homeManagerConfiguration {
                inherit system username;
                homeDirectory = "/Users/${username}";
                configuration.imports = [ ./home.nix ];
              };
          in {
            runner = mkconfig "runner";
            sestrella = mkconfig "sestrella";
          };
      };
    };
}
