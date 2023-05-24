args:

builtins.concatLists
  (map (plugin: import plugin args) [
    ./plugins/auto-dark-mode.nix
    ./plugins/cmp.nix
    ./plugins/comment.nix
    ./plugins/lspconfig.nix
    ./plugins/lualine.nix
    ./plugins/null-ls.nix
    ./plugins/solarized.nix
    ./plugins/telescope.nix
    ./plugins/which-key.nix
    ./plugins/whitespace.nix
  ])
