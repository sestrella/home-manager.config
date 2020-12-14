{ pkgs, ... }:

let
  rgPath = "${pkgs.ripgrep}/bin/rg";
in {
  home.sessionVariables = {
    EDITOR = "nvim";
  };

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

      " airline
      let g:airline_powerline_fonts = 1
      " ctrlp
      set grepprg=${rgPath}\ --color=never

      let g:ctrlp_use_caching = 0
      let g:ctrlp_user_command = '${rgPath} %s --files --color=never --glob ""'
      " nerdtree
      let g:NERDTreeShowHidden = 1

      nnoremap <C-n> :NERDTreeToggle<CR>
      " solarized
      colorscheme solarized
    '';
    plugins = with pkgs.vimPlugins; [
      bats-vim
      coc-nvim
      ctrlp-vim
      nerdcommenter
      nerdtree
      typescript-vim
      vim-airline
      vim-colors-solarized
      vim-jsx-typescript
      vim-nix
      vim-obsession
      vim-projectionist
      vim-sensible
      vim-trailing-whitespace
    ];
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
  };

  xdg.configFile."nvim/coc-settings.json".source = ./coc-settings.json;
}
