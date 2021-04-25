{ pkgs, ... }:

let
  rg = "${pkgs.ripgrep}/bin/rg";
  settings = import ../../settings.nix;
  # TODO: compile neovim 0.5
  sources = import ../../nix/sources.nix {};
  nixpkgs-unstable = import sources.nixpkgs-unstable {};
  tree-sitter = nixpkgs-unstable.tree-sitter;
  neovim = pkgs.neovim-unwrapped.overrideAttrs (old: {
    version = "v0.5.0";
    src = (import ../../nix/sources.nix {}).neovim;
      #owner  = "neovim";
      #repo   = "neovim";
      #rev    = "bb33727922ca4549bb3b9b7aaaac1b535154b669";
      #sha256 = "0xy4ky8gaqwa8acmh1vkijx2hln6y8c1mxj2yqzg9q6cv3ffrlgf";
    #};

    # buildInputs = old.buildInputs ++ [ pkgs.tree-sitter ];
    cmakeFlags = old.cmakeFlags ++ [
      "-DTreeSitter_INCLUDE_DIR=${pkgs.tree-sitter}/include/tree_sitter"
      "-DTreeSitter_LIBRARY=${tree-sitter}/lib/libtree-sitter.so"
    ];
  });
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

      let mapleader = "\<Space>"
      let maplocalleader = ','
    '';
    #package = neovim;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = ctrlp-vim;
        config = ''
          set grepprg=${rg}\ --color=never

          let g:ctrlp_use_caching = 0
          let g:ctrlp_user_command = '${rg} %s --files --color=never --glob ""'
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
      {
        plugin = vim-colors-solarized;
        config = ''
          syntax enable
          set background=${settings.theme}
          colorscheme solarized
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
