{ config, pkgs, auto-dark-mode, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.lua-language-server
      pkgs.nodePackages.bash-language-server
      pkgs.pyright
      pkgs.rnix-lsp
      pkgs.stylua
      pkgs.terraform-ls
      pkgs.yaml-language-server
    ];
    extraLuaConfig = builtins.readFile ./neovim/extra-config.lua;
    plugins =
      let
        mkPlugin = cfg: {
          inherit (cfg) plugin;
          config = builtins.readFile cfg.configFile;
          type = "lua";
        };
        plugins = [
          # auto-dark-mode
          (mkPlugin {
            plugin = pkgs.vimUtils.buildVimPlugin rec {
              name = "auto-dark-mode.nvim";
              src = auto-dark-mode;
            };
            configFile = ./neovim/auto-dark-mode.lua;
          })
          # vsnip
          pkgs.vimPlugins.vim-vsnip
        ];
        otherPlugins = import ./neovim/plugins.nix { inherit pkgs; };
      in
      plugins ++ otherPlugins;
    vimdiffAlias = true;
  };

  programs.fish.shellAbbrs = {
    vi = "nvim";
    vim = "nvim";
  };
}
