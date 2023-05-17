{ config, pkgs, auto-dark-mode, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.lua-language-server
      pkgs.nodePackages.bash-language-server
      pkgs.pyright
      pkgs.rnix-lsp
      pkgs.stylua
      pkgs.terraform-ls
      pkgs.yaml-language-server
    ];
    extraLuaConfig = builtins.readFile ./neovim/extra-config.lua;
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
            ./neovim/whitespace.nix
          ];
        plugins = [
          # auto-dark-mode
          (mkPlugin {
            plugin = pkgs.vimUtils.buildVimPlugin rec {
              name = "auto-dark-mode.nvim";
              src = auto-dark-mode;
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
          # comment
          (mkPlugin {
            plugin = pkgs.vimPlugins.comment-nvim;
            configFile = ./neovim/comment.lua;
          })
          # lspconfig
          (mkPlugin {
            plugin = pkgs.vimPlugins.nvim-lspconfig;
            configFile = ./neovim/lspconfig.lua;
          })
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
          pkgs.vimPlugins.nvim-treesitter-refactor
          pkgs.vimPlugins.nvim-treesitter-textobjects
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
