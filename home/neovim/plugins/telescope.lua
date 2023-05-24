require("telescope").setup({
	pickers = {
		git_files = {
			show_untracked = true,
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<c-p>", builtin.git_files, { desc = "Find files" })

-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
