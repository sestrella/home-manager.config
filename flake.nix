{
  description = "My home-manager configuration";

  inputs = {
    auto-dark-mode-nvim.flake = false;
    auto-dark-mode-nvim.url = "github:f-person/auto-dark-mode.nvim";
    devenv.url = "github:cachix/devenv";
    home-manager-diff.url = "github:pedorich-n/home-manager-diff";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:sestrella/home-manager/ghostty_validate_config";
    mac-app-util.url = "github:hraban/mac-app-util";
    nixd.url = "github:nix-community/nixd";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    tmux-dark-notify.flake = false;
    tmux-dark-notify.url = "github:erikw/tmux-dark-notify";
    which-key-nvim.flake = false;
    which-key-nvim.url = "github:folke/which-key.nvim";
  };

  outputs = inputs: {
    homeConfigurations =
      let
        mkHomeManagerConfig =
          { system, module }:
          inputs.home-manager.lib.homeManagerConfiguration {
            modules = [
              inputs.mac-app-util.homeManagerModules.default
              inputs.home-manager-diff.hmModules.default
              module
            ];
            pkgs = import inputs.nixpkgs {
              inherit system;
              # https://nixos.wiki/wiki/Overlays
              overlays = [
                inputs.devenv.overlays.default
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
                    which-key-nvim = prev.vimUtils.buildVimPlugin {
                      name = "which-key.nvim";
                      src = inputs.which-key-nvim;
                    };
                  };
                  nixd = inputs.nixd.packages.${system}.default;
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
