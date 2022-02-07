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
        config = ''
          let g:haskell_classic_highlighting=1
        '';
      }
      # Reference: https://github.com/hrsh7th/vim-vsnip#2-setting
      # {
      #   plugin = plugins.vim-vsnip;
      #   config = ''
      #     imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
      #     imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
      #     smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
      #     smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
      #   '';
      # }
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

  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };

  # TODO: Add path to g:vsnip_snippet_dir
  xdg.configFile."nvim/snippets" = {
    source = ./snippets;
    recursive = true;
  };
}
