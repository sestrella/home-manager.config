{ pkgs }:

{
  plugin = pkgs.vimPlugins.null-ls-nvim;
  config = builtins.readFile ./null-ls.lua;
  type = "lua";
}
