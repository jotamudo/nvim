return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects"
  },
  config = function()
    require "nvim-treesitter.configs".setup {
      ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      highlight = {
        enable = true, -- false will disable the whole extension
        --additional_vim_regex_highlighting = { "markdown" }
        use_languagetree = false,
        disable = function(_, bufnr)
          local buf_name = vim.api.nvim_buf_get_name(bufnr)
          local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
          return file_size > 256 * 1024
        end,
      }
      --indent = {
      --enable = true
      --}
    }
  end
}
