{
  description = "A minimal flake template that you can adapt to your own project";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-config.url = "github:sestrella/home-manager.config?ref=export-module";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs =
    {
      home-manager,
      home-manager-config,
      nixpkgs,
      ...
    }:
    let
      system = "aarch64-darwin";
    in
    {
      homeConfigurations.sestrella = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          home-manager-config.homeModules.default
          # ./home.nix
        ];
      };
    };
}
