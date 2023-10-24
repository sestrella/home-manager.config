{
  description = "A collection of my favorite vim plugins";

  inputs = {
    auto-dark-mode-nvim.url = "github:f-person/auto-dark-mode.nvim";
    auto-dark-mode-nvim.flake = false;
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md
        packages = {
          auto-dark-mode-nvim = pkgs.vimUtils.buildVimPlugin {
            name = "auto-dark-mode.nvim";
            src = inputs.auto-dark-mode-nvim;
          };
        };

        # https://nixos.wiki/wiki/Overlays
        overlays.default = final: prev: {
          vimPlugins = prev.vimPlugins.extend(final': prev': {
            auto-dark-mode-nvim = packages.auto-dark-mode-nvim;
          });
        };
      });
}
