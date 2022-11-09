{ pkgs }:

# https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md#treesitter
{
  plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins
    (plugins: [
      plugins.tree-sitter-dockerfile
      plugins.tree-sitter-haskell
      plugins.tree-sitter-hcl
      plugins.tree-sitter-markdown
      plugins.tree-sitter-nix
      plugins.tree-sitter-rust
      plugins.tree-sitter-yaml
    ]);
  config = ''
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
    })
  '';
  type = "lua";
}
