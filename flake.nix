{
  description = "A Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      home-manager = inputs.home-manager.defaultPackage.${system};
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      system = "x86_64-darwin";
    in {
      devShell.${system} = import ./shell.nix {
        inherit home-manager pkgs;
      };
      packages.${system} = {
        homeConfigurations = {
          sestrella = inputs.home-manager.lib.homeManagerConfiguration {
            inherit system;
            homeDirectory = "/Users/sestrella";
            username = "sestrella";
            configuration.imports = [ ./home.nix ];
          };
        };
      };
    };
}
