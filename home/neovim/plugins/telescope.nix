{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.telescope-nvim;
    config = builtins.readFile ./telescope.lua;
    type = "lua";
  }
]
