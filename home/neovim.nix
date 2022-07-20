{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua << EOF
      vim.o.expandtab = true
      vim.o.laststatus = 3
      vim.o.number = true
      vim.o.shiftwidth = 2
      vim.o.softtabstop = 2
      vim.o.tabstop = 2
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = ''
          local lspconfig = require("lspconfig")

          local on_attach = function(client, bufnr)
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
          end

          local default_options = {
            on_attach = on_attach
          }

          local servers = {
            rnix = {
              cmd = { "${pkgs.rnix-lsp}/bin/rnix-lsp" }
            }
          }

          for server, options in pairs(servers) do
            lspconfig[server].setup(vim.tbl_extend("keep", options, default_options))
          end
        '';
        type = "lua";
      }
      {
        plugin = nvim-solarized-lua;
        config = ''
          vim.o.termguicolors = true
          vim.g.solarized_termtrans = 1
          vim.cmd('colorscheme solarized')
        '';
        type = "lua";
      }
      {
        plugin = nvim-treesitter;
        config = ''
          require("nvim-treesitter.configs").setup({
              ensure_installed = {
              "haskell",
                "javascript",
                "json",
                "lua",
                "markdown",
                "nix",
                "python",
                "ruby",
                "rust",
                "toml",
                "yaml"
              },
            highlight = {
              enable = true
            }
          })
        '';
        type = "lua";
      }
      {
        plugin = telescope-nvim;
        config = ''
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<c-p>", builtin.git_files, {})
        '';
        type = "lua";
      }
      # TODO: Remove this plugin
      playground
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
