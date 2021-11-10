{ pkgs, ... }:

let
  sources = import ./nix/sources.nix {};
  plugins = builtins.listToAttrs (builtins.map (name: {
    name = name;
    value = pkgs.vimUtils.buildVimPluginFrom2Nix (let
      source = sources."${name}";
    in {
      pname = name;
      src = source;
      version = source.rev;
    });
  }) (builtins.attrNames sources));
in {
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    # config
    extraConfig = ''
      set number
      set colorcolumn=80

      set expandtab
      set shiftwidth=2
      set softtabstop=2
      set tabstop=2

      set splitbelow
      set splitright

      set termguicolors

      " INFO: Avoid issues running :checkhealth
      let g:loaded_perl_provider=0
      let g:loaded_python_provider=0
      let g:loaded_ruby_provider=0

      let mapleader = "\<Space>"
      let maplocalleader = ','

      nnoremap <c-l> :nohlsearch<cr>

      lua require('config')
    '';
    plugins = [
      {
        plugin = pkgs.vimPlugins.haskell-vim;
        config = ''
          let g:haskell_classic_highlighting=1
        '';
      }
      {
        plugin = pkgs.vimPlugins.NeoSolarized;
        config = ''
          set background=light
          colorscheme NeoSolarized
        '';
      }
      {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        config = ''
          lua require('nvim-tree').setup()

          nnoremap <C-n> :NvimTreeToggle<CR>
        '';
      }
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = ''
          nnoremap <C-p> <cmd>Telescope find_files<CR>
        '';
      }
      # Reference: https://github.com/hrsh7th/vim-vsnip#2-setting
      {
        plugin = plugins.vim-vsnip;
        config = ''
          imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
          imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
          smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
          smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
        '';
      }
      pkgs.vimPlugins.lsp-colors-nvim
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.surround
      pkgs.vimPlugins.vim-better-whitespace
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.vim-rails
      pkgs.vimPlugins.vim-terraform
      plugins.cmp-buffer
      plugins.cmp-cmdline
      plugins.cmp-nvim-lsp
      plugins.cmp-path
      plugins.cmp-vsnip
      plugins.friendly-snippets
      plugins.lspkind-nvim
      plugins.nvim-cmp
      plugins.nvim-lspconfig
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
