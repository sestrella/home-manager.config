{
  # https://nix-community.github.io/home-manager/index.html#sec-flakes-nix-darwin-module
  inputs = {
    # auto-dark-mode.flake = false;
    # auto-dark-mode.url = "github:f-person/auto-dark-mode.nvim";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:LnL7/nix-darwin";
    devenv.url = "github:cachix/devenv";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    vim-plugins.url = "path:flakes/vim-plugins";
  };

  outputs =
    { self
    , vim-plugins
    , darwin
    , devenv
    , flake-utils
    , home-manager
    , nixpkgs
    }@inputs:
    let
      mkDarwinSystem = system: darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              backupFileExtension = "bak";
              extraSpecialArgs = { vim-plugins-overlays = inputs.vim-plugins.overlays.${system}; };
              users.sestrella = import ./home.nix;
            };
          }
        ];
      };
    in
    {
      darwinConfigurations = {
        ci = mkDarwinSystem "x86_64-darwin";
        work = mkDarwinSystem "aarch64-darwin";
      };

    } // flake-utils.lib.eachSystem [ "aarch64-darwin" "x86_64-darwin" ]
      (system:
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

              pre-commit.hooks = {
                luacheck.enable = true;
                nixpkgs-fmt.enable = true;
                stylua.enable = true;
                yamllint.enable = true;
              };
            })
          ];
        };
      });
}
