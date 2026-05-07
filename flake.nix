{
  description = "Home Manager configuration of sestrella";

  inputs = {
    devenv.url = "github:cachix/devenv/v2.0";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs =
    {
      devenv,
      home-manager,
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
                overlays = [ devenv.overlays.default ];
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
