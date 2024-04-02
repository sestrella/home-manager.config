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
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    plugins = builtins.concatMap (plugin: pkgs.callPackage plugin { }) [
      ./plugins/auto-dark-mode
      ./plugins/cmp
      ./plugins/comment
      ./plugins/gitsigns
      ./plugins/lspconfig
      ./plugins/lualine
      ./plugins/null-ls
      ./plugins/solarized
      ./plugins/telescope
      ./plugins/treesitter
      ./plugins/whitespace
    ];
    vimdiffAlias = true;
  };

  programs.fish.shellAbbrs = {
    vi = "nvim";
    vim = "nvim";
  };
}
