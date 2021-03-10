{ pkgs, ... }:

{
  programs.vim = {
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

      " ctrlp
      set grepprg=${pkgs.ripgrep}/bin/rg\ --color=never

      let g:ctrlp_use_caching = 0
      let g:ctrlp_user_command = '${pkgs.ripgrep}/bin/rg %s --files --color=never --glob ""'
      " nerdtree
      let g:NERDTreeShowHidden = 1

      nnoremap <C-n> :NERDTreeToggle<CR>

      " vim-airline
      let g:airline_powerline_fonts = 1

      " vim-colors-solarized
      syntax enable
      set background=dark
      colorscheme solarized
    '';

    plugins = with pkgs.vimPlugins; [
      ctrlp-vim
      nerdcommenter
      nerdtree
      typescript-vim
      vim-airline
      vim-colors-solarized
      vim-jsx-typescript
      vim-nix
      vim-projectionist
      vim-rails
      vim-sensible
      vim-snippets
      vim-trailing-whitespace
    ];
  };
}
