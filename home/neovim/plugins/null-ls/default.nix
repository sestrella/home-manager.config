{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.null-ls-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
