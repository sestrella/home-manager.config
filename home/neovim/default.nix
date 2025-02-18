{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    # defaultEditor = true;
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    extraPackages = [
      # pkgs.bash-language-server
      pkgs.golines
      # pkgs.gopls
      pkgs.nixd
      # pkgs.nodejs
      # pkgs.pyright
      # pkgs.ruby-lsp
      # pkgs.terraform-ls
      # pkgs.typescript-language-server
      # pkgs.vscode-langservers-extracted
      # pkgs.yaml-language-server
      pkgs.lua-language-server
      pkgs.nixfmt-rfc-style
      pkgs.stylua
    ];
    plugins = [
      pkgs.vimPlugins.auto-dark-mode-nvim
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-nvim-lsp-signature-help
      pkgs.vimPlugins.cmp-vsnip
      pkgs.vimPlugins.comment-nvim
      pkgs.vimPlugins.conform-nvim
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-solarized-lua
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.vim-vsnip
      pkgs.vimPlugins.which-key-nvim
    ];
    # plugins = builtins.concatMap (plugin: pkgs.callPackage plugin { }) [
    #   ./plugins/auto-dark-mode
    #   ./plugins/comment
    #   ./plugins/conform
    #   ./plugins/gitsigns
    #   ./plugins/lsp
    #   ./plugins/lualine
    #   ./plugins/solarized
    #   ./plugins/telescope
    #   ./plugins/treesitter
    #   ./plugins/which-key
    #   ./plugins/whitespace
    # ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
