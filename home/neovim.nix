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
        mkPlugin = cfg: {
          inherit (cfg) plugin;
          config = builtins.readFile cfg.configFile;
          type = "lua";
        };
        pluginsWithConfig = map
          (plugin: (import plugin { inherit pkgs; }))
          [
            ./neovim/lspconfig.nix
            ./neovim/whitespace.nix
          ];
        plugins = [
          # auto-dark-mode
          (mkPlugin {
            plugin = pkgs.vimUtils.buildVimPlugin rec {
              name = "auto-dark-mode.nvim";
              src = pkgs.fetchFromGitHub {
                owner = "f-person";
                repo = name;
                rev = "a02ff9ee4630dd8e81dc097b486b7c7f468b9db7";
                sha256 = "V5/VEY45wlJD9KRRc27ZTuWWnI3YlJOISW+X8gKgJ6U=";
              };
            };
            configFile = ./neovim/auto-dark-mode.lua;
          })
          # cmp
          (mkPlugin {
            plugin = pkgs.vimPlugins.nvim-cmp;
            configFile = ./neovim/cmp.lua;
          })
          pkgs.vimPlugins.cmp-buffer
          pkgs.vimPlugins.cmp-nvim-lsp
          pkgs.vimPlugins.cmp-path
          pkgs.vimPlugins.cmp-vsnip
          # null-ls
          (mkPlugin {
            plugin = pkgs.vimPlugins.null-ls-nvim;
            configFile = ./neovim/null-ls.lua;
          })
          # solarized
          (mkPlugin {
            plugin = pkgs.vimPlugins.nvim-solarized-lua;
            configFile = ./neovim/solarized.lua;
          })
          # telescope
          (mkPlugin {
            plugin = pkgs.vimPlugins.telescope-nvim;
            configFile = ./neovim/telescope.lua;
          })
          # treesitter
          (mkPlugin {
            plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins
              (plugins: [
                plugins.tree-sitter-dockerfile
                plugins.tree-sitter-haskell
                plugins.tree-sitter-hcl
                plugins.tree-sitter-lua
                plugins.tree-sitter-markdown
                plugins.tree-sitter-nix
                plugins.tree-sitter-rust
                plugins.tree-sitter-terraform
                plugins.tree-sitter-yaml
              ]);
            configFile = ./neovim/treesitter.lua;
          })
          (mkPlugin {
            plugin = pkgs.vimPlugins.nvim-treesitter-context;
            configFile = ./neovim/treesitter-context.lua;
          })
          pkgs.vimPlugins.playground
          # vsnip
          pkgs.vimPlugins.vim-vsnip
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
