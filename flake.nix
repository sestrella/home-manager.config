{
  description = "My home-manager configuration";

  inputs = {
    auto-dark-mode-nvim.flake = false;
    auto-dark-mode-nvim.url = "github:f-person/auto-dark-mode.nvim";
    devenv.url = "github:cachix/devenv/latest";
    home-manager-diff.url = "github:pedorich-n/home-manager-diff";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    iecs.url = "github:sestrella/iecs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nixd.url = "github:nix-community/nixd";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    tmux-dark-notify.flake = false;
    tmux-dark-notify.url = "github:erikw/tmux-dark-notify";
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
              config.allowUnfree = true;
              # https://nixos.wiki/wiki/Overlays
              overlays = [
                inputs.devenv.overlays.default
                inputs.iecs.overlays.default
                (final: prev: {
                  aider-chat = prev.aider-chat.overrideAttrs (oldAttrs: {
                    version = "0.84.1.dev";
                    src = prev.fetchFromGitHub {
                      owner = "Aider-AI";
                      repo = "aider";
                      # TODO: Pin the version when the following change is
                      # included in the next release:
                      #
                      # https://github.com/Aider-AI/aider/pull/4156
                      rev = "c67f6905a5a885e3904b4cfe04caaf918f6d84fb";
                      hash = "sha256-HgLxvK08GHSaxaxPak87ldQvIYbLms3K+7x2n9XacIY=";
                    };
                  });
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
                  nixd = inputs.nixd.packages.${system}.default;
                })
              ];
            };
          };
      in
      {
        runner = mkHomeManagerConfig {
          system = "aarch64-darwin";
          module = ./runner.nix;
        };
        sestrella = mkHomeManagerConfig {
          system = "aarch64-darwin";
          module = ./sestrella.nix;
        };
      };
  };
}
