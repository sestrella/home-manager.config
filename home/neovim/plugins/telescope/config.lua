-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
local telescope = require("telescope")

telescope.setup({
	defaults = {
		sorting_strategy = "ascending",
	},
	pickers = {
		git_files = {
			show_untracked = true,
		},
	},
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Search for a string in your current working directory " })
vim.keymap.set("n", "<leader>?", builtin.keymaps, { desc = "List normal mode keymappings" })
vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Lists Diagnostics for all open buffers" })
vim.keymap.set("n", "<leader>f", builtin.git_files, { desc = "Fuzzy search through the output of `git ls-files`" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		map("<leader>s", builtin.lsp_document_symbols, "Lists LSP document symbols in the current buffer")
		map("<leader>S", builtin.lsp_workspace_symbols, "Lists LSP document symbols in the current workspace")

		map("gd", builtin.lsp_definitions, "Goto the definition of the word under the cursor")
		map("gi", builtin.lsp_implementations, "Goto the implementation of the word under the cursor")
		map("gr", builtin.lsp_references, "Lists LSP references for word under the cursor")
		map("gy", builtin.lsp_type_definitions, "Goto the definition of the type of the word under the cursor")
	end,
})
