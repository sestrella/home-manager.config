-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
local telescope = require("telescope")

telescope.setup({
	pickers = {
		git_files = {
			show_untracked = true,
		},
	},
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Search for a string and get results live" })
vim.keymap.set("n", "<leader>?", builtin.keymaps, { desc = "List normal mode keymappings" })
vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Lists diagnostics" })
vim.keymap.set("n", "<leader>f", builtin.git_files, { desc = "Fuzzy search for files tracked by Git" })

vim.api.nvim_create_autocmd("LspAttach", {
	-- TODO: rename group
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		map("gd", builtin.lsp_definitions, "Go to definition (LSP)")
		map("gi", builtin.lsp_implementations, "Go to implementation (LSP)")
		map("gr", builtin.lsp_references, "Go to references (LSP)")
		map("gy", builtin.lsp_type_definitions, "Go to type definition (LSP)")

		map("<leader>a", vim.lsp.buf.code_action, "Apply code action (LSP)", { "n", "x" })
		map("<leader>r", vim.lsp.buf.rename, "Rename symbol (LSP)")
	end,
})
