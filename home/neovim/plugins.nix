args:

builtins.concatLists [
  (import ./plugins/cmp.nix args)
  (import ./plugins/lspconfig.nix args)
  (import ./plugins/lualine.nix args)
  (import ./plugins/telescope.nix args)
  (import ./plugins/treesitter.nix args)
  (import ./plugins/which-key.nix args)
]
