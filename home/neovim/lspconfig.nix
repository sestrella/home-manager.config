{ pkgs }:

{
  plugin = pkgs.vimPlugins.nvim-lspconfig;
  config = ''
    -- https://github.com/neovim/nvim-lspconfig#suggested-configuration
    local servers = {
      bashls = {
        cmd = { "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server", "start" }
      },
      lua_ls = {
        cmd = { "${pkgs.lua-language-server}/bin/lua-language-server" },
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            }
          }
        }
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

      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set("<leader>rn", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("<leader>ca", vim.lsp.buf.code_action, bufopts)
      vim.keymap.set("<leader>f", function()
        vim.lsp.buf.format({ async = true })
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
