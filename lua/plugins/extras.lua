return {
  {"szw/vim-maximizer"},
  {"tpope/vim-repeat"},
  {"tpope/vim-surround"},
  {"andymass/vim-matchup"},
  {"itchyny/calendar.vim"},
  {
    "samoshkin/vim-mergetool",
    config = function()
      vim.g.mergetool_layout = "mr"
      vim.g.mergetool_prefer_revision = "local"
    end
  },
  {"gennaro-tedesco/nvim-jqx"},
  {"normen/vim-pio"}
}
