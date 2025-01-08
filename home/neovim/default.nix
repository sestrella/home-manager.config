{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.bash-language-server
      pkgs.gopls
      pkgs.lua-language-server
      pkgs.nixd
      pkgs.nixfmt-rfc-style
      pkgs.pyright
      pkgs.ruby-lsp
      pkgs.stylua
      pkgs.terraform-ls
      pkgs.typescript-language-server
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
    ];
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    plugins = builtins.concatMap (plugin: pkgs.callPackage plugin { }) [
      # ./plugins/cmp
      # ./plugins/copilot
      # ./plugins/null-ls
      ./plugins/auto-dark-mode
      ./plugins/comment
      ./plugins/conform
      ./plugins/gitsigns
      ./plugins/lspconfig
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
