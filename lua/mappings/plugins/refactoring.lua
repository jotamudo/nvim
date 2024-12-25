return {
    {
        '<leader>re',
        function()
            require('refactoring').refactor('Extract Function')
        end,
        mode = 'v',
    },
    {
        '<leader>rf',
        function()
            require('refactoring').refactor('Extract Function To File')
        end,
        mode = 'v',
    },
    {
        '<leader>rv',
        function()
            require('refactoring').refactor('Extract Variable')
        end,
        mode = 'v',
    },
    {
        '<leader>ri',
        function()
            require('refactoring').refactor('Inline Variable')
        end,
        mode = 'v',
    },
    {
        '<leader>ri',
        function()
            require('refactoring').refactor('Inline Variable')
        end,
    },
    -- call telescope prompt to decide action
    {
        '<leader>rt',
        function()
            require('telescope').extensions.refactoring.refactors()
        end,
        mode = 'v',
    },
    -- You can also use below = true here to to change the position of the printf
    -- statement (or set two remaps for either one). This remap must be made in normal mode.
    {
        '<leader>rp',
        function()
            require('refactoring').debug.printf({ below = false })
        end,
    },
    -- Print var: this remap should be made in visual mode
    {
        '<leader>rv',
        function()
            require('refactoring').debug.print_var({})
        end,
        mode = 'v',
    },
    -- Cleanup function: this remap should be made in normal mode
    {
        '<leader>rc',
        function()
            require('refactoring').debug.cleanup({})
        end,
    },
}
