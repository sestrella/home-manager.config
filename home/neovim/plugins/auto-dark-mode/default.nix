{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.auto-dark-mode-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
  pkgs.vimPlugins.nvim-solarized-lua
]
