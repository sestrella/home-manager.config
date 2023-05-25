{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.auto-dark-mode-nvim;
    config = builtins.readFile ./auto-dark-mode.lua;
    type = "lua";
  }
]
