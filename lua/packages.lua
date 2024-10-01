-- local packer = require("packer")

-- include locally installed luarock packages
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

require("lazy").setup({
  spec = { import ="plugins" }, -- import from `plugins/` folder
  pkg = {
    enabled = true,
    cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
    -- the first package source that is found for a plugin will be used.
    sources = {
      "lazy",
      "rockspec", -- will only be used when rocks.enabled is true
      "packspec",
    },
  },
  rocks = {
    enabled = true,
    root = vim.fn.stdpath("data") .. "/lazy-rocks",
    server = "https://nvim-neorocks.github.io/rocks-binaries/",
  },
  dev = {
    path = "~/.config/nvim/plugins",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {"jotamudo"}, -- For example {"folke"}
  }
})
