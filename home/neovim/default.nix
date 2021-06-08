{ pkgs, ... }:

let
in {
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = [
    pkgs.terraform-ls
    pkgs.yaml-language-server
  ];

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

      set termguicolors

      let mapleader = "\<Space>"
      let maplocalleader = ','
    '';
    package = pkgs.neovim-nightly;
    # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md#what-if-your-favourite-vim-plugin-isnt-already-packaged
    plugins = import ./plugins.nix { inherit pkgs; };
    # vim-jinja
    # vim-jsx-typescript
    # vim-repeat
    # vim-sensible
    # vim-snippets
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim/UltiSnips".source = ./ultisnips;
}
