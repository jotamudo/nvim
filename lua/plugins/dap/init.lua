return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
    {"rcarriga/nvim-dap-ui", config = true},
    "rcarriga/cmp-dap",
    "jay-babu/mason-nvim-dap.nvim"
    },
    keys = require("plugins.dap.mappings")
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = {
      automatic_setup = true,
      automatic_installation = true
    }
  }
}
