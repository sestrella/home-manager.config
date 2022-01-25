{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    devShell.x86_64-darwin = import ./shell.nix {
      pkgs = nixpkgs.legacyPackages.x86_64-darwin;
    };
    packages.x86_64-darwin.homeConfigurations =
      let
        mkconfig = username: home-manager.lib.homeManagerConfiguration {
          inherit username;
          system = "x86_64-darwin";
          homeDirectory = "/Users/${username}";
          configuration.imports = [ ./home.nix ];
        };
      in
      {
        runner = mkconfig "runner";
        sestrella = mkconfig "sestrella";
      };
  };
}
