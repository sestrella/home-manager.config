{ pkgs }:

[
  {
    plugin = pkgs.vimPlugins.blink-cmp;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
