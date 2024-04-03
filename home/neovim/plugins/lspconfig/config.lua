-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
local servers = {
	bashls = {},
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
	ruby_ls = {},
	rust_analyzer = {},
	terraformls = {},
	tsserver = {},
	jsonls = {},
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

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")
for server, options in pairs(servers) do
	lspconfig[server].setup(vim.tbl_extend("keep", options, {
		capabilities = capabilities,
	}))
end

-- https://github.com/neovim/nvim-lspconfig
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(event)
		vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		local builtin = require("telescope.builtin")
		map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
		map("gr", builtin.lsp_references, "[G]oto [R]eferences")

		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

		-- TODO: Replace this with https://github.com/stevearc/conform.nvim
		map("<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, "[F]ormat [C]ode")
	end,
})
