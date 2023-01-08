-- nothing
return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {"kyazdani42/nvim-web-devicons"},
  keys = require("mappings.plugins.nvim-tree"),
  config = function ()
    require('nvim-tree').setup{}
  end
}
