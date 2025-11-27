{
  description = "Home Manager configuration of sestrella";

  inputs = {
    devenv.url = "github:cachix/devenv?ref=latest";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    iecs.url = "github:sestrella/iecs";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = inputs: {
    homeConfigurations =
      let
        mkHomeManagerConfig =
          { module }:
          inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs {
              system = "aarch64-darwin";
              config.allowUnfree = true;
              # https://nixos.wiki/wiki/Overlays
              overlays = [
                inputs.devenv.overlays.default
                inputs.iecs.overlays.default
                (
                  final: prev:
                  let
                    pkgs-master = inputs.nixpkgs-master.legacyPackages.${prev.stdenv.hostPlatform.system};
                  in
                  {
                    fish = pkgs-master.fish;
                    gemini-cli = pkgs-master.gemini-cli;
                  }
                )
              ];
            };

            modules = [ module ];
          };
      in
      {
        runner = mkHomeManagerConfig {
          module = ./runner.nix;
        };
        sestrella = mkHomeManagerConfig {
          module = ./sestrella.nix;
        };
      };
  };
}
