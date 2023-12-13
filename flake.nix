{
  description = "Home Manager configuration of Sebastian Estrella";

  inputs = {
    devenv.url = "github:cachix/devenv";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    vim-plugins.url = "github:sestrella/vim-plugins.nix";
  };

  outputs = { devenv, nixpkgs, home-manager, vim-plugins, ... }: {
    homeConfigurations =
      let
        mkHomeManagerConfig = { system, modules }:
          home-manager.lib.homeManagerConfiguration {
            inherit modules;
            pkgs = nixpkgs.legacyPackages.${system};
            extraSpecialArgs = {
              devenv-overlay = (final: prev: {
                devenv = devenv.packages.${system}.default;
              });
              vim-plugins-overlay = vim-plugins.overlays.default;
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
