{ pkgs, ... }:

{
  programs.neovim = {
    enable = false;
    # defaultEditor = true;
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    extraPackages = [
      # pkgs.bash-language-server
      # pkgs.pyright
      # pkgs.ruby-lsp
      # pkgs.typescript-language-server
      pkgs.golines
      pkgs.gopls
      pkgs.lua-language-server
      pkgs.nixd
      pkgs.nixfmt-rfc-style
      pkgs.stylua
      pkgs.terraform-ls
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
    ];
    plugins =
      let
        treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: [
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
      in
      [
        pkgs.vimPlugins.SchemaStore-nvim
        pkgs.vimPlugins.auto-dark-mode-nvim
        pkgs.vimPlugins.cmp-nvim-lsp
        pkgs.vimPlugins.cmp-nvim-lsp-signature-help
        pkgs.vimPlugins.cmp-vsnip
        pkgs.vimPlugins.comment-nvim
        pkgs.vimPlugins.conform-nvim
        pkgs.vimPlugins.nvim-cmp
        pkgs.vimPlugins.nvim-lspconfig
        pkgs.vimPlugins.nvim-solarized-lua
        pkgs.vimPlugins.telescope-fzf-native-nvim
        pkgs.vimPlugins.telescope-nvim
        pkgs.vimPlugins.vim-vsnip
        pkgs.vimPlugins.which-key-nvim
        treesitter
      ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
