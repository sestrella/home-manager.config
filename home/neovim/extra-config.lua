-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamedplus'
vim.o.colorcolumn = '80'
vim.o.cursorline = true
vim.o.inccommand = 'split'

-- tabs
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- windows
vim.o.splitright = true
vim.o.splitbelow = true

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- arrows
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- https://twitter.com/theprimeagen/status/1591996471951429633
vim.keymap.set('n', '<C-u>', '<C-u>zz', {})
vim.keymap.set('n', '<C-d>', '<C-d>zz', {})
vim.keymap.set('n', 'n', 'nzz', {})
-- https://twitter.com/adib_hanna/status/1657074745978781701
vim.keymap.set('n', 'j', 'jzz', {})
vim.keymap.set('n', 'k', 'kzz', {})
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
-- https://vimtricks.com/p/vimtrick-moving-lines/
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
