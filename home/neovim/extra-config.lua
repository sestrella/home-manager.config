-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- TODO: check nerdfonts integration
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.colorcolumn = "80"
vim.o.cursorline = true
vim.o.inccommand = "split"
vim.o.mouse = ""

-- clipboard
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- tabs
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- windows
vim.o.splitright = true
vim.o.splitbelow = true

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- arrows
vim.keymap.set("n", "<left>", '<cmd>echo "Use h instead"<cr>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l instead"<cr>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k instead"<cr>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j instead"<cr>')

-- diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })

-- https://twitter.com/theprimeagen/status/1591996471951429633
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "n", "nzz", {})
-- https://twitter.com/adib_hanna/status/1657074745978781701
vim.keymap.set("n", "j", "jzz", {})
vim.keymap.set("n", "k", "kzz", {})
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
-- https://vimtricks.com/p/vimtrick-moving-lines/
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("extra-config-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		map("<leader>a", vim.lsp.buf.code_action, "Apply code action (LSP)", { "n", "x" })
		map("<leader>r", vim.lsp.buf.rename, "Rename symbol (LSP)")
	end,
})
