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
    plugins = (
      builtins.concatMap (f: pkgs.callPackage f { }) [
        ./plugins/auto-dark-mode
        ./plugins/comment
        ./plugins/conform
        ./plugins/lsp
        ./plugins/oil
        ./plugins/surround
        ./plugins/telescope
        ./plugins/treesitter
        ./plugins/which-key
      ]
    );
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
