{
  description = "Home Manager configuration of sestrella";

  inputs = {
    devenv.url = "github:cachix/devenv?ref=latest";
    # home-manager-diff.url = "github:pedorich-n/home-manager-diff";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # iecs.url = "github:sestrella/iecs";
    # jj.url = "github:jj-vcs/jj";
    # mac-app-util.url = "github:hraban/mac-app-util";
    # nixd.url = "github:nix-community/nixd";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs: {
    homeConfigurations =
      let
        mkHomeManagerConfig =
          { system, module }:
          inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
              # https://nixos.wiki/wiki/Overlays
              overlays = [
                inputs.devenv.overlays.default
                # inputs.iecs.overlays.default
                # inputs.nixd.overlays.default
                # inputs.jj.overlays.default
                (
                  final: prev:
                  let
                    pkgs-master = inputs.nixpkgs-master.legacyPackages.${prev.stdenv.hostPlatform.system};
                  in
                  {
                    # TODO: Pulling an entire channel just for a single package
                    # may be overkill, try using overrideAttrs instead.
                    fish = pkgs-master.fish;
                    gemini-cli = pkgs-master.gemini-cli;
                  }
                )
              ];
            };

            modules = [
              # inputs.mac-app-util.homeManagerModules.default
              # inputs.home-manager-diff.hmModules.default
              module
            ];
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
