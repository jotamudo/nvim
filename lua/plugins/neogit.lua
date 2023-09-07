-- TODO: PLEASE IMPLEMENT THIS FOR Fs SAKE
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim"
  },
  keys = require('mappings/plugins/neogit'),
  config = function ()
    local neogit = require('neogit')

    neogit.setup{
      disable_signs = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      -- customize displayed signs
      signs = {
        -- { CLOSED, OPENED }
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
      },
      integrations = {
        diffview = true
      }
    }
  end
}
