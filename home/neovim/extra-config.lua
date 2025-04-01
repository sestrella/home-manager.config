-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- TODO: check nerdfonts integration
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.colorcolumn = "80"
vim.o.cursorline = true
vim.o.inccommand = "split"

-- clipboard
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- tabs
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- windows
vim.o.splitright = true
vim.o.splitbelow = true

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- arrows
vim.keymap.set("n", "<left>", '<cmd>echo "Use h instead"<cr>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l instead"<cr>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k instead"<cr>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j instead"<cr>')

-- diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })

-- https://twitter.com/theprimeagen/status/1591996471951429633
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "n", "nzz", {})
-- https://twitter.com/adib_hanna/status/1657074745978781701
vim.keymap.set("n", "j", "jzz", {})
vim.keymap.set("n", "k", "kzz", {})
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
-- https://vimtricks.com/p/vimtrick-moving-lines/
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-------------
-- PLUGINS --
-------------

require("auto-dark-mode").setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.api.nvim_set_option_value("background", "dark", {})
		vim.cmd("colorscheme solarized")
	end,
	set_light_mode = function()
		vim.api.nvim_set_option_value("background", "light", {})
		vim.cmd("colorscheme solarized")
	end,
})

require("nvim-treesitter.configs").setup({
	auto_install = false,
	highlight = { enable = true },
})

-- TODO: check default keymaps
require("Comment").setup()

-- From kickstart
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		end,
	},
	-- window = {
	-- 	completion = cmp.config.window.bordered(),
	-- 	documentation = cmp.config.window.bordered(),
	-- },
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

		-- Manually trigger a completion from nvim-cmp.
		--  Generally you don't need this, because nvim-cmp will display
		--  completions whenever it has completion options available.
		["<C-Space>"] = cmp.mapping.complete({}),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "vsnip" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})

local lspconfig = require("lspconfig")
local schemastore = require("schemastore")

local servers = {
	lua_ls = {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
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
	gopls = {},
	jsonls = {
		settings = {
			json = {
				schemas = schemastore.json.schemas(),
				validate = { enable = true },
			},
		},
	},
	terraformls = {},
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = "",
				},
				schemas = schemastore.yaml.schemas(),
			},
		},
	},
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for server, config in pairs(servers) do
	config.capabilities = capabilities
	lspconfig[server].setup(config)
end

local builtin = require("telescope.builtin")

-- https://github.com/nvim-lua/kickstart.nvim
vim.api.nvim_create_autocmd("LspAttach", {
	-- TODO: rename group
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		map("gd", builtin.lsp_definitions, "Goto definition")
		map("gi", builtin.lsp_implementations, "Goto implementation")
		map("gr", builtin.lsp_references, "Goto references")
		map("gy", builtin.lsp_type_definitions, "Goto type definition")

		map("<leader>a", vim.lsp.buf.code_action, "Perform code action", { "n", "x" })
		map("<leader>r", vim.lsp.buf.rename, "Rename symbol")
	end,
})

require("conform").setup({
	formatters_by_ft = {
		go = { "golines" },
		lua = { "stylua" },
		nix = { "nixfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

local wk = require("which-key")
wk.add({
	{ "<leader>", group = "Space" },
	{ "g", group = "Goto" },
})
