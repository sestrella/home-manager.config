{ pkgs }:

{
  plugin = pkgs.vimPlugins.nvim-cmp;
  config = builtins.readFile ./cmp.lua;
  type = "lua";
}
