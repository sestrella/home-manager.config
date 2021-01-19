{ pkgs, ... }:

let
  rgPath = "${pkgs.ripgrep}/bin/rg";
in {
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = [
    pkgs.ripgrep
    pkgs.rnix-lsp
  ];

  programs.neovim = {
    enable = true;
    # config
    extraConfig = ''
      set colorcolumn=80
      set number

      set expandtab
      set shiftwidth=2
      set softtabstop=2
      set tabstop=2

      set splitbelow
      set splitright

      set nobackup
      set noswapfile
      set noundofile

      let mapleader = "\<Space>"
      let maplocalleader = ','
    '';
    plugins = with pkgs.vimPlugins; [
      bats-vim
      #coc-nvim
      #completion-nvim
      {
        plugin = ctrlp-vim;
        config = ''
          set grepprg=${rgPath}\ --color=never

          let g:ctrlp_use_caching = 0
          let g:ctrlp_user_command = '${rgPath} %s --files --color=never --glob ""'
        '';
      }
      nerdcommenter
      {
        plugin = nerdtree;
        config = ''
          let g:NERDTreeShowHidden = 1

          nnoremap <C-f> :NERDTreeFind<CR>
          nnoremap <C-t> :NERDTreeToggle<CR>
        '';
      }
      typescript-vim
      #ultisnips
      {
        plugin = vim-airline;
        config = ''
          let g:airline_powerline_fonts = 1
        '';
      }
      {
        plugin = vim-colors-solarized;
        config = ''
          colorscheme solarized
        '';
      }
      vim-jsx-typescript
      vim-nix
      vim-projectionist
      vim-sensible
      #vim-snippets
      vim-trailing-whitespace
    ];
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython = true;
  };

  xdg.configFile."nvim/coc-settings.json".source = ./coc-settings.json;
}
