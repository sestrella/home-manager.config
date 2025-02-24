-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
	pickers = {
		git_files = {
			show_untracked = true,
		},
	},
	-- extensions = {
	-- 	["ui-select"] = {
	-- 		require("telescope.themes").get_dropdown(),
	-- 	},
	-- },
})

telescope.load_extension("fzf")
-- telescope.load_extension("ui-select")

vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Search for a string and get results live" })
vim.keymap.set("n", "<leader>?", builtin.keymaps, { desc = "List normal mode keymappings" })
vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Lists diagnostics" })
vim.keymap.set("n", "<leader>f", builtin.git_files, { desc = "Fuzzy search for files tracked by Git" })

-- vim.keymap.set("n", "<leader>/", function()
-- 	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
-- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
-- 		winblend = 10,
-- 		previewer = false,
-- 	}))
-- end, { desc = "[/] Fuzzily search in current buffer" })
