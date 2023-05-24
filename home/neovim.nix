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
    plugins = import ./neovim/plugins.nix {
      inherit auto-dark-mode pkgs;
    };
    vimdiffAlias = true;
  };

  programs.fish.shellAbbrs = {
    vi = "nvim";
    vim = "nvim";
  };
}
