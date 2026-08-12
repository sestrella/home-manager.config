{
  description = "A minimal flake template that you can adapt to your own project";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-config.url = "path:../../";
    # home-manager-config.url = "path:/Users/sestrella/.config/home-manager";
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
      homeConfigurations.runner = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          home-manager-config.homeModules.default
          ./home.nix
        ];
      };
    };
}
