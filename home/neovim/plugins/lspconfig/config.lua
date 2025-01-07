-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
local servers = {
	bashls = {},
	gopls = {},
	jsonls = {},
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
	yamlls = {
		settings = {
			yaml = {
				schemas = {
					["https://devenv.sh/devenv.schema.json"] = "devenv.yaml",
					["https://json.schemastore.org/circleciconfig.json"] = "/.circleci/config.yml",
					["https://json.schemastore.org/dependabot-2.0.json"] = "/.github/dependabot.yml",
					["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.yml",
					["kubernetes"] = "*.k8s.yml",
				},
			},
		},
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local lspconfig = require("lspconfig")
for server, options in pairs(servers) do
	lspconfig[server].setup(vim.tbl_extend("keep", options, {
		capabilities = capabilities,
	}))
end

-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/nvim-lua/kickstart.nvim
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(event)
		-- vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local map = function(keys, f, desc)
			vim.keymap.set("n", keys, f, { buffer = event.buf, desc = desc })
		end

		local builtin = require("telescope.builtin")

		map("gd", builtin.lsp_definitions, "Goto definition")
		map("gi", builtin.lsp_implementations, "Goto implementation")
		map("gr", builtin.lsp_references, "Goto references")
		map("gy", builtin.lsp_type_definitions, "Goto type definition")

		map("<leader>a", vim.lsp.buf.code_action, "Perform code action")
		map("<leader>r", vim.lsp.buf.rename, "Rename symbol")
	end,
})
