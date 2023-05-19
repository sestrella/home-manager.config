args:

builtins.concatLists [
  (import ./plugins/lualine.nix args)
  (import ./plugins/which-key.nix args)
]
