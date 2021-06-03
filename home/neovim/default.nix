{ pkgs, ... }:

let
  # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md#what-if-your-favourite-vim-plugin-isnt-already-packaged
  sources = import ../../nix/sources.nix {};
  compe = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-compe";
    src = sources.nvim-compe;
  };
  telescope = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "telescope.nvim";
    src = sources."telescope.nvim";
  };
  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  lspConfigs = {
    rnix = pkgs.rnix-lsp;
    terraformls = pkgs.terraform-ls;
    tflint = pkgs.tflint;
    yamlls = pkgs.yaml-language-server;
  };
in {
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = builtins.attrValues lspConfigs;

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

      set spell
      set spelllang=en

      let mapleader = "\<Space>"
      let maplocalleader = ','
    '';
    package = pkgs.neovim-nightly;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = compe;
        config = ''
          lua <<EOF
            vim.o.completeopt = "menuone,noselect"

            require'compe'.setup {
              enabled = true;
              autocomplete = true;
              debug = false;
              min_length = 1;
              preselect = 'enable';
              throttle_time = 80;
              source_timeout = 200;
              incomplete_delay = 400;
              max_abbr_width = 100;
              max_kind_width = 100;
              max_menu_width = 100;
              documentation = true;

              source = {
                path = true;
                buffer = true;
                calc = true;
                nvim_lsp = true;
                nvim_lua = true;
                vsnip = true;
                ultisnips = true;
              };
            }
          EOF
        '';
      }
      {
        plugin = telescope;
        config = ''
          nnoremap <C-p> <cmd>Telescope find_files<cr>
        '';
      }
      {
        plugin = NeoSolarized;
        config = ''
          colorscheme NeoSolarized
        '';
      }
      nerdcommenter
      {
        plugin = nerdtree;
        config = ''
          let g:NERDTreeShowHidden = 1

          nnoremap <C-n> :NERDTreeToggle<CR>
        '';
      }
      {
        plugin = nvim-lspconfig;
        config = let
          names = builtins.attrNames lspConfigs;
          servers = builtins.map (name: "require'lspconfig'.${name}.setup{}") names;
        in ''
          lua <<EOF
            require'lspconfig'.yamlls.setup{
              settings = {
                yaml = {
                  schemas = {
                    ["https://json.schemastore.org/circleciconfig.json"] = ".circleci/config.yml"
                  }
                }
              }
            }
          EOF
        '';
      }
      typescript-vim
      {
        plugin = ultisnips;
        config = ''
          let g:UltiSnipsExpandTrigger = '<tab>'
          let g:UltiSnipsJumpBackwardTrigger = '<c-z>'
          let g:UltiSnipsJumpForwardTrigger = '<c-b>'
        '';
      }
      {
        plugin = vim-airline;
        config = ''
          let g:airline_powerline_fonts = 1
        '';
      }
      vim-jinja
      vim-jsx-typescript
      vim-nix
      vim-projectionist
      vim-rails
      vim-repeat
      vim-sensible
      vim-snippets
      vim-surround
      vim-trailing-whitespace
    ];
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim/UltiSnips".source = ./ultisnips;
}
