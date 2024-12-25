return {
    {
        '<leader>gg',
        function()
            require('neogit').open()
        end,
    },
    {
        '<leader>gc',
        function()
            require('neogit').open({ 'commit' })
        end,
    },
}
