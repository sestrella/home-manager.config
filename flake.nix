{
  description = "Home Manager configuration of Sebastian Estrella";

  inputs = {
    devenv.url = "github:cachix/devenv";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    vim-plugins.url = "github:sestrella/home-manager.config?dir=flakes/vim-plugins";
    vim-plugins.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { devenv, nixpkgs, home-manager, vim-plugins, ... }: {
    homeConfigurations =
      let
        mkHomeManagerConfig = { system, modules }:
          home-manager.lib.homeManagerConfiguration {
            inherit modules;
            pkgs = import nixpkgs {
              inherit system;
              overlays = [
                (final: prev: {
                  devenv = devenv.packages.${system}.default;
                })
                vim-plugins.overlays.${system}.default
              ];
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
