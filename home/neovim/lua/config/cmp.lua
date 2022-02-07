-- INFO: https://github.com/hrsh7th/nvim-cmp#recommended-configuration
vim.o.completeopt = 'menuone,noselect'

local cmp = require('cmp');

cmp.setup({
    formatting = {format = require('lspkind').cmp_format()},
    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-y>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'vsnip'}},
                                 {{name = 'buffer'}})
});

cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}});

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
});
