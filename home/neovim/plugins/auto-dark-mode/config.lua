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
