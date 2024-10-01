return {
  {
    "nvimtools/none-ls.nvim",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
      "williamboman/mason.nvim",
      "jayp0521/mason-null-ls.nvim",
      "nvimtools/none-ls-extras.nvim",
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
      local null_ls = require("null-ls")
      mason_null_ls.setup({
          automatic_installation = false,
          automatic_setup = true -- Recommended, but optional
        })
      null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.completion.spell,
            null_ls.builtins.formatting.clang_format,
            null_ls.builtins.formatting.yamlfix,
            null_ls.builtins.formatting.yamlfmt,
            require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
        }
      })
    end
  }
}
