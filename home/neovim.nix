{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua vim.o.number = true
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
      pkgs.vimPlugins.playground
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
