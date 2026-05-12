{
  description = "Home Manager configuration of sestrella";

  inputs = {
    devenv.url = "github:cachix/devenv/v2.1";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw= cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM=";
    extra-substituters = "https://devenv.cachix.org https://cachix.cachix.org";
  };

  outputs =
    {
      devenv,
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
            config.allowUnfree = true; # Required to install GH Copilot CLI
            overlays = [ devenv.overlays.default ];
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
