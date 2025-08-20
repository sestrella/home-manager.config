{ pkgs, ... }:

[
  {
    # plugin = pkgs.vimPlugins.auto-dark-mode-nvim;
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "auto-dark-mode.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "f-person";
        repo = "auto-dark-mode.nvim";
        rev = "e300259ec777a40b4b9e3c8e6ade203e78d15881";
        hash = "sha256-PhhOlq4byctWJ5rLe3cifImH56vR2+k3BZGDZdQvjng=";
      };
    };
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
  pkgs.vimPlugins.nvim-solarized-lua
]
