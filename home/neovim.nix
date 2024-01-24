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
      ./neovim/plugins/auto-dark-mode
      ./neovim/plugins/cmp
      ./neovim/plugins/comment
      ./neovim/plugins/lspconfig
      ./neovim/plugins/lualine
      ./neovim/plugins/null-ls
      ./neovim/plugins/solarized
      ./neovim/plugins/telescope
      ./neovim/plugins/treesitter
      ./neovim/plugins/which-key
      ./neovim/plugins/whitespace
    ];
    vimdiffAlias = true;
  };

  programs.fish.shellAbbrs = {
    vi = "nvim";
    vim = "nvim";
  };
}
