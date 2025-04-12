{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.comment-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
