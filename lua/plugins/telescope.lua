return {
    'nvim-telescope/telescope.nvim',
    keys = require('mappings/plugins/telescope'),
    branch = 'master',
    cmd = 'Telescope',
    dependencies = {
        'nvim-telescope/telescope-media-files.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local actions = require('telescope.actions')
        local trouble = require('trouble.providers.telescope')
        local open_with_trouble = require('trouble.sources.telescope').open

        local telescope = require('telescope')
        telescope.setup({
            file_ignore_patterns = {
                '.git',
                'node_modules',
                '__pycache__',
                'plugged*',
                'plugged_b*',
            },
            defaults = {
                mappings = {
                    i = { ['<c-s-t>'] = open_with_trouble },
                    n = { ['<c-s-t>'] = open_with_trouble },
                },
                path_display = {
                    'truncate',
                    filename_first = {
                        reverse_directories = false,
                    },
                },
            },
            sorting_strategy = 'descending',
        })
        -- telescope.load_extension('fzf')
        -- {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        telescope.load_extension('media_files')
        telescope.load_extension('refactoring')
    end,
}
