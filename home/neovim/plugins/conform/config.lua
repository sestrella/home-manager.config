-- https://github.com/nvim-lua/kickstart.nvim
require("conform").setup({
	formatters_by_ft = {
		go = { "golines" },
		lua = { "stylua" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
