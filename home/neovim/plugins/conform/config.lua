require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		go = { "gofmt" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		terraform = { "terraform_fmt" },
	},
})
