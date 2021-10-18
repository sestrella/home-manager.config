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
      nvim-lspconfig
      cmp-buffer
      cmp-nvim-lsp
      # INFO: References:
      # https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
      # https://github.com/hrsh7th/nvim-cmp#recommended-configuration
      {
        plugin = nvim-cmp;
        config = ''
          set completeopt=menu,menuone,noselect

          lua <<EOF
            local cmp = require('cmp');
            cmp.setup({
              mapping = {
                -- TODO: Fix me
                -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
              },
              sources = {
                { name = 'buffer' },
                { name = 'nvim_lsp' }
              }
            });

            -- TODO: Update cmp-nvim-lsp
            -- local capabilities = vim.lsp.protocol.make_client_capabilities();
            -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities);

            local lspconfig = require('lspconfig');
            lspconfig.rnix.setup({
              cmd = { '${pkgs.rnix-lsp}/bin/rnix-lsp' },
              -- capabilities = capabilities
            });
            lspconfig.solargraph.setup({
              cmd = { '${pkgs.solargraph}/bin/solargraph', 'stdio' },
              -- capabilities = capabilities
            });
            lspconfig.rust_analyzer.setup({
              cmd = { '${pkgs.rust-analyzer}/bin/rust-analyzer' },
              -- capabilities = capabilities
            });
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
