require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		go = { "gofmt" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		python = { "black" },
		terraform = { "terraform" },
	},
	formatters = {
		terraform = {
			command = "terraform",
			args = { "fmt" },
		},
	},
})
