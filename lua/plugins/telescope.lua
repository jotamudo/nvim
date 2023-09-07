return {
  "nvim-telescope/telescope.nvim",
  keys = require("mappings/plugins/telescope"),
  dependencies = {
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local actions = require("telescope.actions")
    local trouble = require("trouble.providers.telescope")

    local telescope = require("telescope")
    telescope.setup {
      file_ignore_patterns = {".git", "node_modules", "__pycache__", "plugged*", "plugged_b*"},
      defaults = {
        mappings = {
          i = {["<c-s-t>"] = trouble.open_with_trouble},
          n = {["<c-s-t>"] = trouble.open_with_trouble}
        }
      },
      sorting_strategy = "descending"
    }
    -- telescope.load_extension('fzf')
    -- {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    telescope.load_extension("media_files")
    telescope.load_extension("refactoring")
  end
}
