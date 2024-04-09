{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.conform-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
