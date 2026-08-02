{
  description = "Home Manager configuration of sestrella";

  inputs = {
    devenv.url = "github:cachix/devenv/v2.1.2";
    herdr.url = "github:ogulcancelik/herdr/v0.7.5";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      devenv,
      herdr,
      home-manager,
      nixpkgs,
      ...
    }:
    let
      mkHomeManagerConfig =
        { username }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            overlays = [
              devenv.overlays.default
              herdr.overlays.default
              (final: prev: import ./packages { pkgs = final; })
            ];
          };

          modules = [
            {
              home = {
                homeDirectory = "/Users/${username}";
                username = username;
              };

              imports = [ ./home.nix ];
            }
          ];
        };
    in
    {
      homeConfigurations = {
        "sebastian.estrella" = mkHomeManagerConfig {
          username = "sebastian.estrella";
        };
        runner = mkHomeManagerConfig {
          username = "runner";
        };
        sestrella = mkHomeManagerConfig {
          username = "sestrella";
        };
      };
    };
}
