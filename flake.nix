{
  description = "sestrella's Home Manager configuration";

  inputs = {
    devenv.url = "github:cachix/devenv/v2.2.2";
    helix-theme-sync.url = "github:sestrella/helix-theme-sync";
    herdr.url = "github:ogulcancelik/herdr/v0.8.0";
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
      self,
      devenv,
      helix-theme-sync,
      herdr,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      apps.${system}.default = {
        type = "app";
        program = "${pkgs.lib.getExe home-manager.packages.${system}.default}";
        meta.description = ''
          This wrapper is intended to be used only the first time home-manager
          is invoked. Subsequent calls can invoke home-manager directly from PATH.
        '';
      };

      devShells.${system}.default = devenv.lib.mkShell {
        inherit inputs pkgs;

        modules = [
          {
            packages = [
              pkgs.pre-commit
              pkgs.swift-format
              pkgs.swiftpm
              pkgs.swiftpm2nix
            ];

            languages.swift.enable = true;

            git-hooks.hooks = {
              actionlint.enable = true;
              gitleaks = {
                enable = true;
                entry = pkgs.lib.getExe pkgs.gitleaks;
                args = [
                  "git"
                  "--pre-commit"
                  "--redact"
                  "--staged"
                  "--verbose"
                ];
                pass_filenames = false;
              };
              shellcheck.enable = true;
            };
          }
        ];
      };

      checks = self.packages;

      formatter.${system} = pkgs.nixfmt-tree;

      homeConfigurations.sestrella = self.lib.homeConfiguration {
        username = "sestrella";
      };

      lib.homeConfiguration =
        {
          username,
          modules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            {
              nixpkgs.overlays = [
                devenv.overlays.default
                helix-theme-sync.overlays.default
                herdr.overlays.default
                (final: prev: import ./packages { pkgs = final; })
              ];

              home.homeDirectory = "/Users/${username}";
              home.username = username;
            }
            helix-theme-sync.homeModules.default
            ./home.nix
          ]
          ++ modules;
        };

      packages.${system} = import ./packages { inherit pkgs; };

      templates.default = {
        path = ./templates/default;
        description = "Extends sestrella's Home Manager configuration";
      };
    };
}
