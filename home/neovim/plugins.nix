args:

builtins.concatLists [
  (import ./plugins/cmp.nix args)
  (import ./plugins/comment.nix args)
  (import ./plugins/lspconfig.nix args)
  (import ./plugins/lualine.nix args)
  (import ./plugins/null-ls.nix args)
  (import ./plugins/solarized.nix args)
  (import ./plugins/telescope.nix args)
  (import ./plugins/which-key.nix args)
]
