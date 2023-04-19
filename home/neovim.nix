{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '

      vim.o.cmdheight = 0
      vim.o.colorcolumn = "80"
      vim.o.cursorline = true
      vim.o.expandtab = true
      vim.o.ignorecase = true
      vim.o.number = true
      vim.o.relativenumber = true
      vim.o.shiftwidth = 2
      vim.o.softtabstop = 2
      vim.o.splitbelow = true
      vim.o.splitright = true
      vim.o.tabstop = 2

      -- https://twitter.com/theprimeagen/status/1591996471951429633
      vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {})
      vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {})
    '';
    plugins =
      let
        pluginsWithConfig = map
          (plugin: (import plugin { inherit pkgs; }))
          [
            # TODO: merge cmp and lspconfig
            ./neovim/cmp.nix
            ./neovim/dark-notify.nix
            ./neovim/lspconfig.nix
            ./neovim/null-ls.nix
            ./neovim/solarized.nix
            ./neovim/telescope.nix
            ./neovim/treesitter.nix
            ./neovim/whitespace.nix
          ];
        plugins = [
          pkgs.vimPlugins.cmp-buffer
          pkgs.vimPlugins.cmp-nvim-lsp
          pkgs.vimPlugins.cmp-path
          pkgs.vimPlugins.cmp-vsnip
          pkgs.vimPlugins.markdown-preview-nvim
          pkgs.vimPlugins.playground
          pkgs.vimPlugins.vim-vsnip
          {
            plugin = pkgs.vimPlugins.nvim-treesitter-context;
            config = ''
              require('treesitter-context').setup({
                enable = true
              })
            '';
            type = "lua";
          }
        ];
      in
      pluginsWithConfig ++ plugins;
    vimdiffAlias = true;
  };

  programs.fish.shellAbbrs = {
    vi = "nvim";
    vim = "nvim";
  };
}
