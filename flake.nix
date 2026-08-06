{
  description = "Home Manager configuration of sestrella";

  inputs = {
    devenv.url = "github:cachix/devenv/v2.1";
    herdr.url = "github:ogulcancelik/herdr/v0.7.5";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  nixConfig = {
    extra-substituters = [
      "https://devenv.cachix.org"
      "https://herdr.cachix.org"
      "https://nix-community.cachix.org"
      "https://sestrella.cachix.org"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "herdr.cachix.org-1:3nH7IStRsS0ASfdonA0DCRR2ZrSCeWitZ7Kwew0cR4I="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "sestrella.cachix.org-1:uf75o4yckcsAOFu6ldfPug/kTUMybvT0IY61sck2qnA="
    ];
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
