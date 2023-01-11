{ pkgs }:

{
  plugin = pkgs.vimPlugins.null-ls-nvim;
  config = ''
    local null_ls = require("null-ls")
    
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.shfmt
      }
    })
  '';
  type = "lua";
}
