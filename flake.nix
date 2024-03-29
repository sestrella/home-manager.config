{
  description = "My Home Manager configuration";

  inputs = {
    auto-dark-mode-nvim.flake = false;
    auto-dark-mode-nvim.url = "github:f-person/auto-dark-mode.nvim";
    devenv.url = "github:cachix/devenv";
    home-manager-diff.url = "github:pedorich-n/home-manager-diff";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    tmux-dark-notify.flake = false;
    tmux-dark-notify.url = "github:erikw/tmux-dark-notify";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    homeConfigurations =
      let
        mkHomeManagerConfig = { system, module }:
          home-manager.lib.homeManagerConfiguration {
            modules = [
              inputs.home-manager-diff.hmModules.default
              module
            ];
            # TODO: Refactor taking into account: https://zimbatm.com/notes/1000-instances-of-nixpkgs
            pkgs = import nixpkgs {
              inherit system;
              # https://nixos.wiki/wiki/Overlays
              overlays = [
                (final: prev: {
                  tmuxPlugins = prev.tmuxPlugins // {
                    tmux-dark-notify = prev.tmuxPlugins.mkTmuxPlugin {
                      pluginName = "tmux-dark-notify";
                      rtpFilePath = "main.tmux";
                      src = inputs.tmux-dark-notify;
                    };
                  };
                  vimPlugins = prev.vimPlugins // {
                    auto-dark-mode-nvim = prev.vimUtils.buildVimPlugin {
                      name = "auto-dark-mode.nvim";
                      src = inputs.auto-dark-mode-nvim;
                    };
                  };
                })
              ];
            };

            extraSpecialArgs = {
              devenv = inputs.devenv.packages.${system}.default;
            };
          };
      in
      {
        runner = mkHomeManagerConfig {
          system = "x86_64-linux";
          module = ./runner.nix;
        };
        sestrella = mkHomeManagerConfig {
          system = "aarch64-darwin";
          module = ./sestrella.nix;
        };
      };
  };
}
