return {
  {
    "nvimtools/none-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "jayp0521/mason-null-ls.nvim"
    },
    config = true
  },
  {
    "jayp0521/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      local mason_null_ls = require("mason-null-ls")
      mason_null_ls.setup({
          automatic_installation = false,
          automatic_setup = true -- Recommended, but optional
        })
      require("null-ls").setup()
    end
  }
}
