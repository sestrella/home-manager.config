{
  description = "My Home Manager configuration";

  inputs = {
    auto-dark-mode-nvim.flake = false;
    auto-dark-mode-nvim.url = "github:f-person/auto-dark-mode.nvim";
    devenv.url = "github:cachix/devenv";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    tmux-dark-notify.flake = false;
    tmux-dark-notify.url = "github:erikw/tmux-dark-notify";
  };

  outputs = inputs@{ self, devenv, nixpkgs, home-manager, ... }: {
    homeConfigurations =
      let
        mkHomeManagerConfig = { system, modules }:
          home-manager.lib.homeManagerConfiguration {
            inherit modules;
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
          modules = [ ./runner.nix ];
        };
        sestrella = mkHomeManagerConfig {
          system = "aarch64-darwin";
          modules = [ ./sestrella.nix ];
        };
      };
  };
}
