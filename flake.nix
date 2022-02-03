{
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
    in
    {
      devShell."${system}" = import ./shell.nix {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (self: super: {
              home-manager = home-manager.defaultPackage."${system}";
            })
          ];
        };
      };
      packages."${system}".homeConfigurations =
        let
          mkconfig = username: home-manager.lib.homeManagerConfiguration {
            inherit username system;
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
