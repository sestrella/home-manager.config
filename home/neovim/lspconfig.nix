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
      ruby_ls = {},
      rust_analyzer = {},
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

    local lspconfig = require("lspconfig")
    for server, options in pairs(servers) do
      lspconfig[server].setup(vim.tbl_extend("keep", options, {
        capabilities = capabilities
      }))
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = ev.buf }

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end
    })
  '';
  type = "lua";
}
