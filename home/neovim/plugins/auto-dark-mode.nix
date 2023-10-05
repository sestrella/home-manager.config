{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.auto-dark-mode;
    config = builtins.readFile ./auto-dark-mode.lua;
    type = "lua";
  }
]
