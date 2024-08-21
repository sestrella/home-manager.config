local wk = require("which-key")

wk.setup()

-- Document existing key chains
wk.add({
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>d", group = "[D]ocument" },
	{ "<leader>r", group = "[R]ename" },
	{ "<leader>s", group = "[S]earch" },
	{ "<leader>w", group = "[W]orkspace" },
	{ "<leader>t", group = "[T]oggle" },
	{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
})
