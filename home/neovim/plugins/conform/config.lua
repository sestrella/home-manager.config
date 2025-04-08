-- https://github.com/nvim-lua/kickstart.nvim
local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		go = { "golines" },
		lua = { "stylua" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

vim.api.nvim_create_user_command("Format", function()
	conform.format({ async = true, lsp_format = "fallback" })
end, {})
