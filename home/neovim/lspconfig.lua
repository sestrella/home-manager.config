local servers = {
  bashls = {},
  rnix = {},
  rust_analyzer = {},
  sumneko_lua = {
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
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>f", function()
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
