return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = { "BufReadPre ".. vim.fn.expand('~') .."/Documents/Brain/**.md" },
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    dir = "~/Documents/Brain",  -- no need to call 'vim.fn.expand' here
    templates = {
          subdir = "Templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M"
    },
  },

  keys = require("mappings.plugins.obsidian"),

}