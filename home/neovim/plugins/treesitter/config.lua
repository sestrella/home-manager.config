-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
require("nvim-treesitter.configs").setup({
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
	-- incremental_selection = {
	-- 	enable = true,
	-- 	keymaps = {
	-- 		init_selection = "<c-space>",
	-- 		node_incremental = "<c-space>",
	-- 		scope_incremental = "<c-s>",
	-- 		-- TODO: Fix this keymap for macOS
	-- 		node_decremental = "<M-space>",
	-- 	},
	-- },
})
