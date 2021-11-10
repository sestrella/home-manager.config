-- INFO: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities();
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities);

local lspconfig = require('lspconfig');
local servers = {
  'hls',
  'rnix',
  'rust_analyzer',
  'solargraph',
};

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    capabilities = capabilities,
  });
end
