{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    extraPackages = [
      pkgs.golines
      pkgs.gopls
      pkgs.lua-language-server
      pkgs.nixd
      pkgs.nixfmt-rfc-style
      pkgs.nodejs
      pkgs.stylua
      pkgs.terraform-ls
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
    ];
    plugins =
      (builtins.concatMap (f: pkgs.callPackage f { }) [
        ./plugins/auto-dark-mode
        ./plugins/telescope
        ./plugins/treesitter
      ])
      ++ [
        pkgs.vimPlugins.SchemaStore-nvim
        pkgs.vimPlugins.cmp-nvim-lsp
        pkgs.vimPlugins.cmp-nvim-lsp-signature-help
        pkgs.vimPlugins.cmp-vsnip
        pkgs.vimPlugins.comment-nvim
        pkgs.vimPlugins.conform-nvim
        pkgs.vimPlugins.copilot-cmp
        pkgs.vimPlugins.copilot-lua
        pkgs.vimPlugins.nvim-cmp
        pkgs.vimPlugins.nvim-lspconfig
        pkgs.vimPlugins.vim-vsnip
        pkgs.vimPlugins.which-key-nvim
      ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
