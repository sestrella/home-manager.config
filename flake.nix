{
  description = "My Home Manager configuration";

  inputs = {
    devenv.url = "github:cachix/devenv";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self, devenv, nixpkgs, home-manager }: {
    homeConfigurations =
      let
        mkHomeManagerConfig = { system, modules }:
          home-manager.lib.homeManagerConfiguration {
            inherit modules;
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ devenv.overlays.default ];
            };
          };
      in
      {
        runner = mkHomeManagerConfig {
          system = "x86_64-linux";
          modules = [ ./runner.nix ];
        };
        sestrella = mkHomeManagerConfig {
          system = "aarch64-darwin";
          modules = [ ./sestrella.nix ];
        };
      };
  };
}
