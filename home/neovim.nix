{ pkgs, ... }:

{
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
    plugins = with pkgs.vimPlugins; [
      {
        plugin = haskell-vim;
        config = ''
          let g:haskell_classic_highlighting=1
        '';
      }
      {
        plugin = NeoSolarized;
        config = ''
          set background=light
          colorscheme NeoSolarized
        '';
      }
      # TODO: WIP
      # {
      #   plugin = nvim-cmp;
      #   config = ''
      #     lua <<EOF
      #       vim.o.completeopt = 'menuone,noselect'

      #       local cmp = require('cmp')
      #       cmp.setup({
      #         snippet = {
      #           expand = function(args)
      #             require('luasnip').lsp_expand(args.body)
      #           end
      #         },
      #        sources = {
      #           { name = 'nvim_lsp' }
      #         }
      #       })
      #     EOF
      #   '';
      # }
      {
        plugin = nvim-lspconfig;
        config = ''
          lua <<EOF
            local lspconfig = require('lspconfig')

            lspconfig.rnix.setup({
              cmd = { '${pkgs.rnix-lsp}/bin/rnix-lsp' }
            })

            lspconfig.solargraph.setup({
              cmd = { '${pkgs.solargraph}/bin/solargraph', 'stdio' }
            })
          EOF
        '';
      }
      {
        plugin = nvim-tree-lua;
        config = ''
          nnoremap <C-n> :NvimTreeToggle<CR>
        '';
      }
      {
        plugin = nvim-web-devicons;
        config = ''
          lua <<EOF
            require'nvim-web-devicons'.setup {
              default = true;
            }
          EOF
        '';
      }
      surround
      {
        plugin = telescope-nvim;
        config = ''
          nnoremap <C-p> <cmd>Telescope find_files<CR>
        '';
      }
      {
        plugin = lualine-nvim;
        config = ''
          lua <<EOF
            require('lualine').setup({
              options = { theme = 'solarized' }
            })
          EOF
        '';
      }
      {
        plugin = lsp-colors-nvim;
        config = ''
          lua <<EOF
            require("lsp-colors").setup({
              Error = "#db4b4b",
              Warning = "#e0af68",
              Information = "#0db9d7",
              Hint = "#10B981"
            })
          EOF
        '';
      }
      vim-better-whitespace
      vim-nix
      vim-rails
      vim-terraform
    ];
    viAlias = true;
    vimAlias = true;
  };
}
