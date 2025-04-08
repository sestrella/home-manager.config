{ pkgs }:

[
  {
    plugin = pkgs.vimPlugins.mini-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
