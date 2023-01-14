{ pkgs }:

# https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md#treesitter
{
  plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins
    (plugins: [
      plugins.tree-sitter-dockerfile
      plugins.tree-sitter-haskell
      plugins.tree-sitter-hcl
      plugins.tree-sitter-lua
      plugins.tree-sitter-markdown
      plugins.tree-sitter-nix
      plugins.tree-sitter-rust
      plugins.tree-sitter-yaml
    ]);
  config = ''
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true
      },
      playground = {
        enable = true
      }
    })

    require("vim.treesitter.query").set_query("nix", "injections", [[
      (binding_set
        (binding
          (attrpath
            attr: (identifier) @_config (#eq? @_config "config"))

          (indented_string_expression
            (string_fragment) @lua))

        (binding
          (attrpath
            attr: (identifier) @_type (#eq? @_type "type"))

          (string_expression
            (string_fragment) @_value (#eq? @_value "lua"))))
    ]])
  '';
  type = "lua";
}
