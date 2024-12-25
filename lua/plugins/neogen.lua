return {
    'danymat/neogen',
    dependencies = {
        'L3MON4D3/LuaSnip',
    },
    keys = {
        {
            '<Leader>nf',
            function()
                require('neogen').generate()
            end,
            silent = true,
        },
        {
            '<Leader>nc',
            function()
                require('neogen').generate({ type = 'class' })
            end,
            silent = true,
        },
    },
    -- vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
    opts = {
        snippet_engine = 'luasnip',
    },
}
