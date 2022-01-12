{
  description = "A Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-darwin";
    in {
      devShell.${system} = import ./shell.nix {
        home-manager = home-manager.defaultPackage.${system};
        pkgs = nixpkgs.legacyPackages.${system};
      };
      packages.${system} = {
        homeConfigurations =
          let
            config = username:
              home-manager.lib.homeManagerConfiguration {
                inherit system username;
                homeDirectory = "/Users/${username}";
                configuration.imports = [ ./home.nix ];
              };
          in {
            runner = config "runner";
            sestrella = config "sestrella";
          };
      };
    };
}
