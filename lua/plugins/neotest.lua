return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-neotest/neotest-python',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        -- need to do this at function(), with the opts table the code would be called
        -- instantly and the requires would fail as no module exists on the rtp.
        require('neotest').setup({
            adapters = {
                require('neotest-python')({
                    dap = { justMyCode = false },
                    pytest_discover_instances = true,
                }),
            },
        })
    end,
}
