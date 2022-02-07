local lspconfig = require('lspconfig');

local opts = {noremap = true, silent = true};
local keymaps = {
  ['<leader>f'] = '<cmd>lua vim.lsp.buf.formatting()<CR>',
  ['<leader>rn'] = '<cmd>lua vim.lsp.buf.rename()<CR>',
};

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc');
    for lhs, rhs in pairs(keymaps) do
      vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, opts);
    end
end

local servers = {'rnix', 'rust_analyzer', 'yamlls'};

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        flags = {debounce_text_changes = 150}
    });
end
