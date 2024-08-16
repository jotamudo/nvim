return {
  "nvim-orgmode/orgmode",
  enabled = false,
  dependencies = {
    "akinsho/org-bullets.nvim",
    "lukas-reineke/headlines.nvim", -- general highlighting of headlines
    "dhruvasagar/vim-table-mode" -- table support
  },
  config = function()
    local org = require('orgmode')
    org.setup();
    -- org.setup_ts_grammar()
  end
}
