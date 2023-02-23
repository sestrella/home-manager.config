{ pkgs }:

{
  plugin = pkgs.vimPlugins.nvim-lspconfig;
  config = ''
    -- https://github.com/neovim/nvim-lspconfig#suggested-configuration
    local servers = {
      bashls = {},
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
      rnix = {},
      rust_analyzer = {},
      terraformls = {},
      yamlls = {
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

      local nmap = function(keys, func)
        vim.keymap.set("n", keys, func, {
          buffer = bufnr,
          noremap = true,
          silent = true
        })
      end

      nmap("<leader>rn", vim.lsp.buf.rename)
      nmap("<leader>ca", vim.lsp.buf.code_action)
      nmap("<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end)
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
