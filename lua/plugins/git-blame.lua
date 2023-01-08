return {
  "f-person/git-blame.nvim",
  keys = require('mappings/plugins/git-blame'),
  config = function()
    vim.g.gitblame_enabled = 0
  end
}
