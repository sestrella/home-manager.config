{ pkgs }:

{
  plugin = pkgs.vimPlugins.telescope-nvim;
  config = ''
    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<c-p>", builtin.git_files, {})
  '';
  type = "lua";
}
