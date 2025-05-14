{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.avante-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
