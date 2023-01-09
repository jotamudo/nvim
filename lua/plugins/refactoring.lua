return {
  "ThePrimeagen/refactoring.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  keys = require("mappings.plugins.refactoring"),
  config = {
    -- prompt for return type
    prompt_func_return_type = {
      go = true,
      cpp = true,
      c = true,
      java = true
    },
    -- prompt for function parameters
    prompt_func_param_type = {
      go = true,
      cpp = true,
      c = true,
      java = true
    }
  }
}
