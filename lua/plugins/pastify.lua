return {
    'TobinPalmer/pastify.nvim',
    cmd = { 'Pastify', 'PastifyAfter' },
    config = function()
        require('pastify').setup({
            opts = {
                absolute_path = false,
                local_path = 'Files/',
                save = 'local_file',
            },
        })
    end,
}
