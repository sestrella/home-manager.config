{ pkgs }:

[
  {
    plugin = pkgs.vimPlugins.nvim-lspconfig;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
  pkgs.vimPlugins.cmp-nvim-lsp
  pkgs.vimPlugins.cmp-nvim-lsp-signature-help
  pkgs.vimPlugins.nvim-cmp
]
