{ pkgs }:

{
  # https://github.com/neovim/nvim-lspconfig#suggested-configuration
  plugin = pkgs.vimPlugins.nvim-lspconfig;
  config = builtins.readFile ./lspconfig.lua;
  type = "lua";
}
