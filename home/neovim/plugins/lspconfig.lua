local lspconfig = require('lspconfig');

local opts = { noremap = true, silent = true };

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc');

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts);
end

local servers = { 'rnix' };

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150
    }
  });
end
