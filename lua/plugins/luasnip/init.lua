require("luasnip.loaders.from_vscode").load()
require("luasnip.loaders.from_snipmate").load()

local types = require("luasnip.util.types")
local ls = require('luasnip')

ls.config.setup({
  -- Remember last snippet and let me go back to it even if outside selection
  history = true,

  -- updating as I type
  updateevents = "TextChanged, TextChangedI",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = {{"●", "GruvboxOrange"}}
      }
    },
    [types.insertNode] = {
      active = {
        virt_text = {{"●", "GruvboxBlue"}}
      }
    }
  },
})
