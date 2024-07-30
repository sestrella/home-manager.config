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
	nixd = {
		-- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
		-- settings = {
		-- 	nixd = {
		-- 		options = {
		-- 			home_manager = {
		-- 				expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.sestrella.options',
		-- 			},
		-- 		},
		-- 	},
		-- },
	},
	pyright = {},
	ruby_ls = {},
	rust_analyzer = {},
	terraformls = {},
	tsserver = {},
	yamlls = {
		settings = {
			yaml = {
				schemas = {
					["https://json.schemastore.org/circleciconfig.json"] = "/.circleci/config.yml",
					["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.yml",
					["https://json.schemastore.org/dependabot-2.0.json"] = "/.github/dependabot.yml",
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
		vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local map = function(keys, f, desc)
			vim.keymap.set("n", keys, f, { buffer = event.buf, desc = desc })
		end

		local builtin = require("telescope.builtin")
		map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
		map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
		map("gr", builtin.lsp_references, "[G]oto [R]eferences")

		map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
		map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")

		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
	end,
})
