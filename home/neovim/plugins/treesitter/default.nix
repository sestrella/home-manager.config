{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: [
      plugins.tree-sitter-dockerfile
      plugins.tree-sitter-elixir
      plugins.tree-sitter-go
      plugins.tree-sitter-haskell
      plugins.tree-sitter-haskell-persistent
      plugins.tree-sitter-hcl
      plugins.tree-sitter-javascript
      plugins.tree-sitter-lua
      plugins.tree-sitter-markdown
      plugins.tree-sitter-nix
      plugins.tree-sitter-rust
      plugins.tree-sitter-terraform
      plugins.tree-sitter-yaml
    ]);
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
  #   {
  #     plugin = pkgs.vimPlugins.nvim-treesitter-context;
  #     config = ''
  #       require("treesitter-context").setup()
  #     '';
  #     type = "lua";
  #   }
]
