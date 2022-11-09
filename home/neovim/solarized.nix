{ pkgs }:

{
  plugin = pkgs.vimPlugins.nvim-solarized-lua;
  config = ''
    vim.o.termguicolors = true
    vim.cmd("colorscheme solarized")
  '';
  type = "lua";
}
