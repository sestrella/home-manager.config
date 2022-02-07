{ pkgs, ... }:

let
  readLuaFile = source: ''
    lua << EOF
    ${builtins.readFile source}
    EOF
  '';
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = [
    pkgs.rnix-lsp
    pkgs.rust-analyzer
    pkgs.yaml-language-server
  ];

  programs.neovim = {
    enable = true;
    # config
    extraConfig = ''
      let mapleader = "\<Space>"
      let maplocalleader = ','

      nnoremap <c-l> :nohlsearch<cr>

      ${readLuaFile ./init.lua}
    '';
    plugins = [
      {
        plugin = pkgs.vimPlugins.haskell-vim;
        config = readLuaFile ./plugins/haskell.lua;
      }
      {
        plugin = pkgs.vimPlugins.NeoSolarized;
        config = readLuaFile ./plugins/neosolarized.lua;
      }
      pkgs.vimPlugins.lsp-colors-nvim
      {
        plugin = pkgs.vimPlugins.lualine-nvim;
        config = readLuaFile ./plugins/lualine.lua;
      }
      {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
        config = readLuaFile ./plugins/lspconfig.lua;
      }
      {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        config = readLuaFile ./plugins/nvim-tree.lua;
      }
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.surround
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = readLuaFile ./plugins/telescope.lua;
      }
      pkgs.vimPlugins.vim-better-whitespace
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.vim-rails
      pkgs.vimPlugins.vim-terraform
      pkgs.vimPlugins.vim-toml
      # Custom plugins
      # TODO: Review LSP configuration
      # plugins.cmp-buffer
      # plugins.cmp-cmdline
      # plugins.cmp-nvim-lsp
      # plugins.cmp-path
      # plugins.cmp-vsnip
      # plugins.comment
      # plugins.friendly-snippets
      # plugins.lspkind-nvim
      # plugins.nvim-cmp
      # plugins.nvim-lspconfig
    ];
    viAlias = true;
    vimAlias = true;
  };
}
