{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.which-key-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
