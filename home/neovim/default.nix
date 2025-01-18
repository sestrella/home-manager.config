{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    extraPackages = [
      pkgs.bash-language-server
      pkgs.golines
      pkgs.gopls
      pkgs.lua-language-server
      pkgs.nixd
      pkgs.nixfmt-rfc-style
      pkgs.nodejs
      pkgs.pyright
      pkgs.ruby-lsp
      pkgs.stylua
      pkgs.terraform-ls
      pkgs.typescript-language-server
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
    ];
    plugins = builtins.concatMap (plugin: pkgs.callPackage plugin { }) [
      ./plugins/auto-dark-mode
      ./plugins/comment
      ./plugins/conform
      ./plugins/gitsigns
      ./plugins/lsp
      ./plugins/lualine
      ./plugins/solarized
      ./plugins/telescope
      ./plugins/treesitter
      ./plugins/which-key
      ./plugins/whitespace
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
