{
  inputs = {
    darwin = {
      url = "github:stackbuilders/nix-darwin/add_pam_reattach_support";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, darwin, home-manager, nixpkgs }: {
    darwinConfigurations =
      let
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.backupFileExtension = "bak";
            home-manager.users.sestrella = import ./home.nix;
          }
        ];
      in
      {
        "Administrators-MacBook-Pro" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit modules;
        };
        "ghactions" = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          inherit modules;
        };
      };
  };
}
