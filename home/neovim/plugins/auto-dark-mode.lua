local auto_dark_mode = require("auto-dark-mode")

local set_mode = function(mode)
	return function()
		vim.api.nvim_set_option("background", mode)
		vim.cmd("colorscheme solarized")
	end
end

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = set_mode("dark"),
	set_light_mode = set_mode("light"),
})
auto_dark_mode.init()
