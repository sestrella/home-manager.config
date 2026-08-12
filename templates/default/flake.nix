{
  description = "Extends sestrella's Home Manager configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager-config.url = "github:sestrella/home-manager.config";
    home-manager-config.url = "path:../../";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
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
      home-manager,
      home-manager-config,
      nixpkgs,
      ...
    }:
    let
      system = "aarch64-darwin";
    in
    {
      homeConfigurations.runner = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          home-manager-config.homeModules.default
          ./home.nix
        ];
      };
    };
}
