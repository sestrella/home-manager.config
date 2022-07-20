{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua << EOF
      vim.o.colorcolumn = "80"
      vim.o.cursorline = true
      vim.o.expandtab = true
      vim.o.laststatus = 3
      vim.o.number = true
      vim.o.shiftwidth = 2
      vim.o.softtabstop = 2
      vim.o.splitbelow = true
      vim.o.splitright = true
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
            local keymaps = {
              ["<space>ca"] = vim.lsp.buf.code_action,
              ["<space>f"] = vim.lsp.buf.formatting,
              ["<space>rn"] = vim.lsp.buf.rename
            }
            for key, value in pairs(keymaps) do
              vim.keymap.set("n", key, value, bufopts)
            end
          end

          local default_options = {
            on_attach = on_attach
          }

          local servers = {
            rnix = {
              cmd = { "${pkgs.rnix-lsp}/bin/rnix-lsp" }
            },
            yamlls = {
              cmd = { "${pkgs.yaml-language-server}/bin/yaml-language-server", "--stdio" },
              settings = {
                yaml = {
                  schemas = {
                    ["https://json.schemastore.org/circleciconfig.json"] = "/.circleci/config.yml",
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.yml",
                    ["https://raw.githubusercontent.com/buildkite/pipeline-schema/main/schema.json"] = "/.buildkite/pipeline.yml",
                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose*.yml"
                  }
                }
              }
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
          vim.cmd("colorscheme solarized")
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
