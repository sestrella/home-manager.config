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

  outputs = inputs@{ self, devenv, nixpkgs, home-manager-diff, home-manager, ... }: {
    homeConfigurations =
      let
        mkHomeManagerConfig = { system, module }:
          home-manager.lib.homeManagerConfiguration {
            modules = [
              home-manager-diff.hmModules.default
              module
            ];
            pkgs = import nixpkgs {
              inherit system;
              # https://nixos.wiki/wiki/Overlays
              overlays = [
                devenv.overlays.default
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
