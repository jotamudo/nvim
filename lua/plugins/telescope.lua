local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')

local telescope = require('telescope')
telescope.setup{
    file_ignore_patterns = {'.git', 'node_modules', '__pycache__', 'plugged*', 'plugged_b*'},
    defaults = {
      mappings = {
        i = { ["<c-s-t>"] = trouble.open_with_trouble },
        n = { ["<c-s-t>"] = trouble.open_with_trouble },
      }
    }
}
telescope.load_extension('fzf')
telescope.load_extension('media_files')
telescope.load_extension('refactoring')
