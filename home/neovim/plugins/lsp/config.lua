local cmp = require("cmp")

-- https://github.com/hrsh7th/nvim-cmp
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		-- Select the [n]ext item
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- Select the [p]revious item
		["<C-p>"] = cmp.mapping.select_prev_item(),

		-- Scroll the documentation window [b]ack / [f]orward
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Accept ([y]es) the completion.
		--  This will auto-import if your LSP supports it.
		--  This will expand snippets if the LSP sent a snippet.
		["<C-y>"] = cmp.mapping.confirm({ select = true }),

		-- If you prefer more traditional completion keymaps,
		-- you can uncomment the following lines
		--['<CR>'] = cmp.mapping.confirm { select = true },
		--['<Tab>'] = cmp.mapping.select_next_item(),
		--['<S-Tab>'] = cmp.mapping.select_prev_item(),

		-- Manually trigger a completion from nvim-cmp.
		--  Generally you don't need this, because nvim-cmp will display
		--  completions whenever it has completion options available.
		["<C-Space>"] = cmp.mapping.complete({}),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
	}, {
		{ name = "buffer" },
	}),
})

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
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
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

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for server, config in pairs(servers) do
	-- config.capabilities = blink.get_lsp_capabilities(config.capabilities)
	config.capabilities = capabilities
	lspconfig[server].setup(config)
end

-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/nvim-lua/kickstart.nvim
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(event)
		-- vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local builtin = require("telescope.builtin")

		local map = function(keys, f, desc)
			vim.keymap.set("n", keys, f, { buffer = event.buf, desc = desc })
		end

		map("gd", builtin.lsp_definitions, "Goto definition")
		map("gi", builtin.lsp_implementations, "Goto implementation")
		map("gr", builtin.lsp_references, "Goto references")
		map("gy", builtin.lsp_type_definitions, "Goto type definition")

		map("<leader>a", vim.lsp.buf.code_action, "Perform code action")
		map("<leader>r", vim.lsp.buf.rename, "Rename symbol")
	end,
})
