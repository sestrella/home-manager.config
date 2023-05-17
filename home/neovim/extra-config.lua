vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.colorcolumn = "80"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.clipboard = "unnamedplus"

-- https://twitter.com/theprimeagen/status/1591996471951429633
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {})
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {})
vim.api.nvim_set_keymap("n", "n", "nzz", {})
-- https://twitter.com/adib_hanna/status/1657074745978781701
vim.api.nvim_set_keymap("n", "j", "jzz", {})
vim.api.nvim_set_keymap("n", "k", "kzz", {})
