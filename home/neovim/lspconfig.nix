{ pkgs }:

let
  nodePackages = pkgs.callPackage ../../node-packages {
    nodejs = pkgs.nodejs-14_x;
  };
  ansibleLanguageServer = nodePackages."@ansible/ansible-language-server-1.x";
in
{
  # https://github.com/neovim/nvim-lspconfig#suggested-configuration
  plugin = pkgs.vimPlugins.nvim-lspconfig;
  config = ''
    local servers = {
      ansiblels = {
        cmd = { "${ansibleLanguageServer}/bin/ansible-language-server", "--stdio" },
      },
      bashls = {
        cmd = { "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server", "start" }
      },
      rnix = {
        cmd = { "${pkgs.rnix-lsp}/bin/rnix-lsp" }
      },
      rust_analyzer = {
        cmd = { "${pkgs.rust-analyzer}/bin/rust-analyzer" }
      },
      terraformls = {
        cmd = { "${pkgs.terraform-ls}/bin/terraform-ls", "serve" }
      },
      yamlls = {
        cmd = { "${pkgs.yaml-language-server}/bin/yaml-language-server", "--stdio" },
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/circleciconfig.json"] = "/.circleci/config.yml",
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.yml"
            }
          }
        }
      }
    }

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local on_attach = function(_client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format { async = true }
      end, bufopts)
    end

    local lspconfig = require("lspconfig")
    for server, options in pairs(servers) do
      lspconfig[server].setup(vim.tbl_extend("keep", options, {
        capabilities = capabilities,
        on_attach = on_attach
      }))
    end
  '';
  type = "lua";
}
