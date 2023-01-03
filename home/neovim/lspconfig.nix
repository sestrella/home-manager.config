{ pkgs }:

{
  plugin = pkgs.vimPlugins.nvim-lspconfig;
  config = builtins.readFile ./lspconfig.lua;
  type = "lua";
}
