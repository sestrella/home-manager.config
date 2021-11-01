{ pkgs, ... }:

let
  sources = import ./nix/sources.nix {};
  overrides = builtins.listToAttrs (builtins.map (name: {
    name = name;
    value = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = name;
      version = "2021-10-28";
      src = sources."${name}";
    };
  }) [
    "cmp-buffer"
    "cmp-cmdline"
    "cmp-nvim-lsp"
    "cmp-path"
    "lspkind-nvim"
    "nvim-cmp"
    "nvim-lspconfig"
  ]);
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
          set background=light
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
            lspconfig.hls.setup({
              capabilities = capabilities,
            });
          EOF
        '';
      }
      overrides.cmp-buffer
      overrides.cmp-cmdline
      overrides.cmp-nvim-lsp
      overrides.cmp-path
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
                ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable,
                ['<C-e>'] = cmp.mapping({
                  i = cmp.mapping.abort(),
                  c = cmp.mapping.close(),
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
              },
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
              }, {
                { name = 'buffer' },
              })
            });

            cmp.setup.cmdline('/', {
              sources = {
                { name = 'buffer' }
              }
            });

            cmp.setup.cmdline(':', {
              sources = cmp.config.sources({
                { name = 'path' }
              }, {
                { name = 'cmdline' }
              })
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
