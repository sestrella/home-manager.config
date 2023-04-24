{
  inputs = {
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, darwin, devenv, flake-utils, home-manager, nixpkgs } @ inputs:
    {
      darwinConfigurations =
        let
          mkDarwinSystem = system: darwin.lib.darwinSystem {
            inherit system;
            modules = [
              ./configuration.nix
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  backupFileExtension = "bak";
                  users.sestrella = import ./home.nix;
                };
              }
            ];
          };
        in
        {
          "Administrators-MacBook-Pro" = mkDarwinSystem "aarch64-darwin";
          "ghactions" = mkDarwinSystem "x86_64-darwin";
        };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            ({ pkgs, ... }: {
              packages = [
                pkgs.gitleaks
              ];

              pre-commit.hooks.nixpkgs-fmt.enable = true;
            })
          ];
        };
      });
}
