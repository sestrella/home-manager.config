{
  description = "Home Manager configuration of sestrella";

  inputs = {
    devenv.url = "github:cachix/devenv?ref=latest";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-master.url = "github:nixos/nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs =
    {
      devenv,
      home-manager,
      nixpkgs-master,
      nixpkgs,
      ...
    }:
    {
      homeConfigurations =
        let
          mkHomeManagerConfig =
            { module }:
            home-manager.lib.homeManagerConfiguration {
              pkgs = import nixpkgs {
                system = "aarch64-darwin";
                config.allowUnfree = true;
                # https://nixos.wiki/wiki/Overlays
                overlays = [
                  devenv.overlays.default
                  (
                    final: prev:
                    let
                      pkgs-master = nixpkgs-master.legacyPackages.${prev.stdenv.hostPlatform.system};
                    in
                    {
                      fish = pkgs-master.fish;
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
