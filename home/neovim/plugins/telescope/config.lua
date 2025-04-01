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
