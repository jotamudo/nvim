return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "jayp0521/mason-null-ls.nvim"
    }
  },
  {
    "jayp0521/mason-null-ls.nvim",
    config = {
      automatic_installation = true,
      automatic_setup = true
    }
  }
}
