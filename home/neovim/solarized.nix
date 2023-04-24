{ pkgs }:

{
  plugin = pkgs.vimPlugins.nvim-solarized-lua;
  config = builtins.readFile ./solarized.lua;
  type = "lua";
}
