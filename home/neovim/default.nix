{ pkgs, ... }:

let
  neovim = pkgs.neovim-unwrapped.overrideAttrs (old: {
    version = "nightly";
    src = (import ../../nix/sources.nix {}).neovim;
    buildInputs = old.buildInputs ++ [ pkgs.tree-sitter ];
  });
  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  lspConfigs = {
    rnix = pkgs.rnix-lsp;
    terraformls = pkgs.terraform-lsp;
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
      set complete+=kspell

      let mapleader = "\<Space>"
      let maplocalleader = ','
    '';
    package = neovim;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = completion-nvim;
        config = ''
          set completeopt=menuone,noinsert,noselect

          let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

          autocmd BufEnter * lua require'completion'.on_attach()
        '';
      }
      {
        plugin = ctrlp-vim;
  	config = let
	  rg = "${pkgs.ripgrep}/bin/rg";
	in ''
          set grepprg=${rg}\ --color=never

          let g:ctrlp_use_caching = 0
          let g:ctrlp_user_command = '${rg} %s --files --color=never --glob ""'
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
            ${builtins.concatStringsSep "\n" servers}
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

  # xdg.configFile."nvim/UltiSnips".source = ./ultisnips;
}
