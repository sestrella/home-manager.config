{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.oil-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
