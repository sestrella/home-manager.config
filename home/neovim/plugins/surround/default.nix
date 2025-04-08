{ pkgs }:

[
  {
    plugin = pkgs.vimPlugins.nvim-surround;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
