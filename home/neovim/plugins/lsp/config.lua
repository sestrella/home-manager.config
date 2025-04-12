local schemastore = require("schemastore")

-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
local servers = {
	bashls = {},
	gopls = {},
	-- https://github.com/b0o/SchemaStore.nvim
	jsonls = {
		settings = {
			json = {
				schemas = schemastore.json.schemas(),
				validate = { enable = true },
			},
		},
	},
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
	lua_ls = {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						-- Depending on the usage, you might want to add additional paths here.
						-- "${3rd}/luv/library"
						-- "${3rd}/busted/library",
					},
					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
					-- library = vim.api.nvim_get_runtime_file("", true)
				},
			})
		end,
		settings = {
			Lua = {},
		},
	},
	nixd = {},
	pyright = {},
	ruby_lsp = {},
	rust_analyzer = {},
	terraformls = {},
	ts_ls = {},
	-- https://github.com/b0o/SchemaStore.nvim
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					-- You must disable built-in schemaStore support if you want to use
					-- this plugin and its advanced options like `ignore`.
					enable = false,
					-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
					url = "",
				},
				schemas = schemastore.yaml.schemas(),
			},
		},
	},
}

local blink = require("blink.cmp")
local lspconfig = require("lspconfig")

blink.setup({
	-- https://cmp.saghen.dev/configuration/fuzzy.html
	fuzzy = { implementation = "rust" },
	-- https://cmp.saghen.dev/configuration/signature.html
	signature = {
		enabled = true,
		window = {
			border = "rounded",
		},
	},
})

for server, config in pairs(servers) do
	config.capabilities = blink.get_lsp_capabilities(config.capabilities)
	lspconfig[server].setup(config)
end
