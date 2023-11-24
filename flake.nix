{
  description = "Home Manager configuration of Sebastian Estrella";

  inputs = {
    devenv.url = "github:cachix/devenv";
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    vim-plugins.url = "path:flakes/vim-plugins";
    vim-plugins.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { devenv, nixpkgs, home-manager, vim-plugins, ... }: {
    homeConfigurations = {
      runner = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./runner.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          devenv = devenv.packages.x86_64-linux.default;
          vim-plugins-overlay = vim-plugins.overlays.x86_64-linux.default;
        };
      };
      sestrella = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./sestrella.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          devenv = devenv.packages.aarch64-darwin.default;
          vim-plugins-overlay = vim-plugins.overlays.aarch64-darwin.default;
        };
      };
    };
  };
}
