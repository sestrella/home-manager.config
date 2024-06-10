local telescope = require("telescope")

telescope.setup({
	pickers = {
		git_files = {
			show_untracked = true,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Search files" })

-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [d]iagnostics" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [g]rep" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [h]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [k]eymaps" })
