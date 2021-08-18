{ pkgs, ... }:

let
  settings = import ../../settings.nix;
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

      " set termguicolors

      " INFO: Avoid issues running :checkhealth
      let g:loaded_perl_provider=0
      let g:loaded_python_provider=0
      let g:loaded_ruby_provider=0

      let mapleader = "\<Space>"
      let maplocalleader = ','

      nnoremap <c-l> :nohlsearch<cr>
    '';
    package = pkgs.neovim-nightly;
    # plugins = import ./plugins.nix { inherit pkgs; };
    plugins = with pkgs.vimPlugins; [
      {
        plugin = lualine-nvim;
        config = ''
          lua <<EOF
            require('lualine').setup({
              options = {
                theme = 'solarized'
              }
            })
          EOF
        '';
      }
      {
        plugin = nvim-compe;
        config = ''
          lua <<EOF
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
              source = {
                path = true;
                buffer = true;
              };
            }
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
      {
        # TODO: Replace with nvim-solarized-lua
        plugin = solarized;
        config = ''
          set background=${settings.theme}
          colorscheme solarized
        '';
      }
      surround
      {
        plugin = telescope-nvim;
        config = ''
          nnoremap <C-p> <cmd>Telescope find_files<CR>
        '';
      }
      vim-nix
      vim-rails
      vim-terraform
    ];
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim/UltiSnips".source = ./ultisnips;
}
