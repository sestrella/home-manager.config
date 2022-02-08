{ pkgs, ... }:

let
  readLuaFile = source: ''
    lua << EOF
    ${builtins.readFile source}
    EOF
  '';
  mkPluginWithLuaConfig = name: {
    plugin = pkgs.vimPlugins.${name};
    config = readLuaFile "./plugins/${name}.lua";
  };
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
    extraConfig = ''
      let mapleader = "\<Space>"
      let maplocalleader = ','

      nnoremap <c-l> :nohlsearch<cr>

      ${readLuaFile ./init.lua}
    '';
    plugins = [
      (mkPluginWithLuaConfig "NeoSolarized")
      (mkPluginWithLuaConfig "haskell-vim")
      (mkPluginWithLuaConfig "lualine-nvim")
      (mkPluginWithLuaConfig "nvim-lspconfig")
      (mkPluginWithLuaConfig "nvim-tree-lua")
      (mkPluginWithLuaConfig "telescope-nvim")
      pkgs.vimPlugins.lsp-colors-nvim
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.surround
      pkgs.vimPlugins.vim-better-whitespace
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.vim-rails
      pkgs.vimPlugins.vim-terraform
      pkgs.vimPlugins.vim-toml
    ];
    viAlias = true;
    vimAlias = true;
  };
}
