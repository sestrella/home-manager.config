{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.gitsigns-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
