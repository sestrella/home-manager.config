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
          set background=dark
          colorscheme NeoSolarized
        '';
      }
      {
        plugin = plugins.nvim-lspconfig;
        config = ''
          lua require('config/lspconfig')
        '';
      }
      {
        plugin = plugins.nvim-cmp;
        # INFO: Reference
        config = ''
          lua require('config/cmp')
        '';
      }
      {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        config = ''
          lua require('nvim-tree').setup()

          nnoremap <C-n> :NvimTreeToggle<CR>
        '';
      }
      # {
      #   plugin = pkgs.vimPlugins.nvim-web-devicons;
      #   config = ''
      #     lua <<EOF
      #       require'nvim-web-devicons'.setup {
      #         default = true;
      #       }
      #     EOF
      #   '';
      # }
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = ''
          nnoremap <C-p> <cmd>Telescope find_files<CR>
        '';
      }
      {
        plugin = pkgs.vimPlugins.lualine-nvim;
        config = ''
          lua require('config/lualine')
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
    ];
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };
}
