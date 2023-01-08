return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects"
  },
  config = function()
    require "nvim-treesitter.configs".setup {
      ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      highlight = {
        enable = true -- false will disable the whole extension
        --additional_vim_regex_highlighting = { "markdown" }
      }
      --indent = {
      --enable = true
      --}
    }
  end
}
