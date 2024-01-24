{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.lua-language-server
      pkgs.nixd
      pkgs.nodePackages.bash-language-server
      pkgs.nodePackages.typescript-language-server
      pkgs.pyright
      pkgs.stylua
      pkgs.terraform-ls
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
    ];
    extraLuaConfig = builtins.readFile ./neovim/extra-config.lua;
    plugins = builtins.concatMap (plugin: pkgs.callPackage plugin { }) [
      ./neovim/plugins/auto-dark-mode.nix
      ./neovim/plugins/cmp.nix
      ./neovim/plugins/comment.nix
      ./neovim/plugins/lspconfig
      ./neovim/plugins/lualine.nix
      ./neovim/plugins/null-ls.nix
      ./neovim/plugins/solarized.nix
      ./neovim/plugins/telescope.nix
      ./neovim/plugins/treesitter
      ./neovim/plugins/which-key.nix
      ./neovim/plugins/whitespace.nix
    ];
    vimdiffAlias = true;
  };

  programs.fish.shellAbbrs = {
    vi = "nvim";
    vim = "nvim";
  };
}
