{
  inputs = {
    auto-dark-mode = {
      url = "github:f-person/auto-dark-mode.nvim";
      flake = false;
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs@{ self, auto-dark-mode, darwin, devenv, flake-parts, home-manager, nixpkgs }:
    let
      mkDarwinSystem = system: darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              backupFileExtension = "bak";
              extraSpecialArgs = { inherit auto-dark-mode; };
              users.sestrella = import ./home.nix;
            };
          }
        ];
      };
      darwinConfigurations = {
        "Administrators-MacBook-Pro" = mkDarwinSystem "aarch64-darwin";
        "ghactions" = mkDarwinSystem "x86_64-darwin";
      };
    in
    {
      inherit darwinConfigurations;
    } // flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];

      systems = [ "aarch64-darwin" "x86_64-darwin" ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devenv.shells.default = {
          packages = [
            pkgs.gitleaks
          ];

          pre-commit.hooks = {
            luacheck.enable = true;
            nixpkgs-fmt.enable = true;
            stylua.enable = true;
            yamllint.enable = true;
          };
        };

        packages = {
          ci = darwinConfigurations."ghactions".system;
          default = darwinConfigurations."Administrators-MacBook-Pro".system;
        };
      };
    };
}
