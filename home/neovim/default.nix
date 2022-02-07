{ pkgs, ... }:

let
  sources = import ./nix/sources.nix { };
  plugins = builtins.listToAttrs (builtins.map
    (name: {
      name = name;
      value = pkgs.vimUtils.buildVimPluginFrom2Nix (
        let
          source = sources."${name}";
        in
        {
          pname = name;
          src = source;
          version = source.rev;
        }
      );
    })
    (builtins.attrNames sources));
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
        config = ''
          lua << EOF
          local handle = io.popen("defaults read -g AppleInterfaceStyle 2> /dev/null", "r")
          local result = handle:read("*a")
          handle:close()

          if result == "Dark\n" then
            vim.o.background = "dark"
          else
            vim.o.background = "light"
          end

          vim.o.termguicolors = true
          vim.cmd("colorscheme NeoSolarized")
          EOF
        '';
      }
      pkgs.vimPlugins.lsp-colors-nvim
      {
        plugin = pkgs.vimPlugins.lualine-nvim;
        config = ''
          lua << EOF
          require('lualine').setup({
            options = { theme = 'solarized' }
          });
          EOF
        '';
      }
      {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        config = ''
          lua << EOF
          require('nvim-tree').setup()
          vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
          EOF
        '';
      }
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.surround
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = ''
          lua vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', {})
        '';
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
