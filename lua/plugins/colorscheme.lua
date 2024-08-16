return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1001,
    config = function()
      -- Colorscheme
      vim.cmd([[
        syntax enable
        colorscheme gruvbox 
        set background=dark
        " hi! Normal ctermbg=None guibg=None
        ]])
    end
  },
  {"folke/tokyonight.nvim"}
}
