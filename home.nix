{ config, pkgs, ... }:

let
  rg="${pkgs.ripgrep}/bin/rg";
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sestrella";
  home.homeDirectory = "/home/sestrella";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";

  home.packages = [
    pkgs.bat
    pkgs.ripgrep
  ];

  programs.fish = {
    enable = true;
    # config
    promptInit = ''
      set -gx NIX_PATH $HOME/.nix-defexpr/channels $NIX_PATH
    '';
    shellAbbrs = {
      # bat
      cat = "bat";
      # git
      ga = "git add";
      gaa = "git add --all";
      gbr = "git branch --remote";
      gc = "git commit -v";
      gco = "git checkout";
      gd = "git diff";
      gl = "git pull";
      gp = "git push";
      gst = "git status";
      # home-manager
      hmg = "home-manager generations";
      hmn = "home-manager news";
      hms = "home-manager switch";
      # tmux
      ta = "tmux attach -t";
      tkss = "tmux kill-session -t";
      tksv = "tmux kill-server";
      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
    };
  };

  programs.git = {
    enable = true;
    # config
    userEmail = "2049686+sestrella@users.noreply.github.com";
    userName = "Sebastián Estrella";
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
      set grepprg=${rg}\ --color=never

      let g:ctrlp_use_caching = 0
      let g:ctrlp_user_command = '${rg} %s --files --color=never --glob ""'
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
      vim-projectionist
      vim-sensible
      vim-trailing-whitespace
    ];
    vimAlias = true;
    withNodeJs = true;
  };

  programs.starship.enable = true;

  programs.tmux = { enable = true;
    # config
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "a";
    terminal = "screen-256color";
  };
}
