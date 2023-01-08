return {
  "nvim-orgmode/orgmode",
  dependencies = {
    "akinsho/org-bullets.nvim",
    "lukas-reineke/headlines.nvim", -- general highlighting of headlines
    "dhruvasagar/vim-table-mode" -- table support
  },
  config = function()
    require('headlines').setup()
  end
}
