{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.telescope-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
  pkgs.vimPlugins.telescope-fzf-native-nvim
  pkgs.vimPlugins.telescope-ui-select-nvim
]
