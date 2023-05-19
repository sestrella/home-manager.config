require("telescope").setup({
	pickers = {
		git_files = {
			show_untracked = true,
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<c-p>", builtin.git_files, { desc = "Find files" })
