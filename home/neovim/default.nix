{ pkgs, ... }:

let
  sources = import ./nix/sources.nix {};
  overrides = builtins.listToAttrs (builtins.map (name: {
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
          set termguicolors
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
            local servers = {
              'hls',
              'rnix',
              'rust_analyzer',
              'solargraph',
            };
            for _, lsp in ipairs(servers) do
              lspconfig[lsp].setup({
                capabilities = capabilities,
              });
            end
          EOF
        '';
      }
      {
        plugin = overrides.nvim-cmp;
        # INFO: Reference
        # https://github.com/hrsh7th/nvim-cmp#recommended-configuration
        config = ''
          lua <<EOF
            vim.o.completeopt = 'menuone,noselect'

            local cmp = require('cmp');

            cmp.setup({
              formatting = {
                format = require('lspkind').cmp_format(),
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
              snippet = {
                expand = function(args)
                  vim.fn["vsnip#anonymous"](args.body)
                end,
              },
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
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
      # {
      #   plugin = pkgs.vimPlugins.nvim-tree-lua;
      #   config = ''
      #     nnoremap <C-n> :NvimTreeToggle<CR>
      #   '';
      # }
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
          lua <<EOF
            require('lualine').setup({
              options = { theme = 'solarized' }
            })
          EOF
        '';
      }
      overrides.cmp-buffer
      overrides.cmp-cmdline
      overrides.cmp-nvim-lsp
      overrides.cmp-path
      overrides.cmp-vsnip
      overrides.friendly-snippets
      overrides.lspkind-nvim
      overrides.vim-vsnip
      pkgs.vimPlugins.lsp-colors-nvim
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.surround
      pkgs.vimPlugins.vim-better-whitespace
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.vim-rails
      pkgs.vimPlugins.vim-terraform
    ];
    viAlias = true;
    vimAlias = true;
  };
}
