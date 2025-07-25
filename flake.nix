{
  description = "My home-manager configuration";

  inputs = {
    devenv.url = "github:cachix/devenv/latest";
    home-manager-diff.url = "github:pedorich-n/home-manager-diff";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    iecs.url = "github:sestrella/iecs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nixd.url = "github:nix-community/nixd";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs: {
    homeConfigurations =
      let
        mkHomeManagerConfig =
          { system, module }:
          inputs.home-manager.lib.homeManagerConfiguration {
            modules = [
              inputs.mac-app-util.homeManagerModules.default
              inputs.home-manager-diff.hmModules.default
              module
            ];
            pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
              # https://nixos.wiki/wiki/Overlays
              overlays = [
                inputs.devenv.overlays.default
                inputs.iecs.overlays.default
                inputs.nixd.overlays.default
                (import ./overlays/gemini-cli)
                (import ./overlays/tmux-plugins)
                (import ./overlays/vim-plugins)
              ];
            };
          };
      in
      {
        runner = mkHomeManagerConfig {
          system = "aarch64-darwin";
          module = ./runner.nix;
        };
        sestrella = mkHomeManagerConfig {
          system = "aarch64-darwin";
          module = ./sestrella.nix;
        };
      };
  };
}
