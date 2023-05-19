{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.nvim-cmp;
    config = builtins.readFile ./cmp.lua;
    type = "lua";
  }
  pkgs.vimPlugins.cmp-buffer
  pkgs.vimPlugins.cmp-nvim-lsp
  pkgs.vimPlugins.cmp-path
  pkgs.vimPlugins.cmp-vsnip
]
