return {
  "brymer-meneses/grammar-guard.nvim",
  requires = {
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer"
  },
  config = function()
    require("grammar-guard").init()
  end,
  ft = {"md"}
}
