{ pkgs, ... }:

let
  sources = import ./nix/sources.nix {};
  overrides = {
    cmp-nvim-lsp = pkgs.vimPlugins.cmp-nvim-lsp.overrideAttrs (_: {
      version = "2021-10-19";
      src = sources.cmp-nvim-lsp;
    });
    lspkind-nvim = pkgs.vimPlugins.lspkind-nvim.overrideAttrs (_: {
      version = "2021-10-19";
      src = sources.lspkind-nvim;
    });
    nvim-cmp = pkgs.vimPlugins.nvim-cmp.overrideAttrs (_: {
      version = "2021-10-19";
      src = sources.nvim-cmp;
    });
    nvim-lspconfig = pkgs.vimPlugins.nvim-lspconfig.overrideAttrs (_ : {
      version = "2021-10-19";
      src = sources.nvim-lspconfig;
    });
  };
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
        plugin = overrides.nvim-lspconfig;
        # INFO: Reference
        # https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
        config = ''
          lua <<EOF
            local capabilities = vim.lsp.protocol.make_client_capabilities();
            capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities);

            local lspconfig = require('lspconfig');
            lspconfig.rnix.setup({
              cmd = { '${pkgs.rnix-lsp}/bin/rnix-lsp' },
              capabilities = capabilities,
            });
            lspconfig.solargraph.setup({
              cmd = { '${pkgs.solargraph}/bin/solargraph', 'stdio' },
              capabilities = capabilities,
            });
            lspconfig.rust_analyzer.setup({
              cmd = { '${pkgs.rust-analyzer}/bin/rust-analyzer' },
              capabilities = capabilities,
            });
          EOF
        '';
      }
      overrides.cmp-nvim-lsp
      overrides.lspkind-nvim
      {
        plugin = overrides.nvim-cmp;
        # INFO: Reference
        # https://github.com/hrsh7th/nvim-cmp#recommended-configuration
        config = ''
          lua <<EOF
            vim.o.completeopt = 'menuone,noselect'

            local cmp = require('cmp');
            local lspkind = require('lspkind');

            cmp.setup({
              formatting = {
                format = lspkind.cmp_format(),
              },
              mapping = {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                },
                ['<Tab>'] = function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  else
                    fallback()
                  end
                end,
                ['<S-Tab>'] = function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  else
                    fallback()
                  end
                end,
              },
              sources = {
                { name = 'nvim_lsp' },
              }
            });
          EOF
        '';
      }
      {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        config = ''
          nnoremap <C-n> :NvimTreeToggle<CR>
        '';
      }
      {
        plugin = pkgs.vimPlugins.nvim-web-devicons;
        config = ''
          lua <<EOF
            require'nvim-web-devicons'.setup {
              default = true;
            }
          EOF
        '';
      }
      pkgs.vimPlugins.surround
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = ''
          nnoremap <C-p> <cmd>Telescope find_files<CR>
        '';
      }
      {
        plugin = pkgs.vimPlugins.lualine-nvim;
        config = ''
          lua <<EOF
            require('lualine').setup({
              options = { theme = 'solarized' }
            })
          EOF
        '';
      }
      {
        plugin = pkgs.vimPlugins.lsp-colors-nvim;
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
      pkgs.vimPlugins.vim-better-whitespace
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.vim-rails
      pkgs.vimPlugins.vim-terraform
    ];
    viAlias = true;
    vimAlias = true;
  };
}
