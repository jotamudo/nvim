return {
  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
    priority = 1001,
    config = function()
      require("gruvbox").setup()
      -- Colorscheme
      vim.cmd([[
        syntax enable
        colorscheme gruvbox 
        set background=dark
        " hi! Normal ctermbg=None guibg=None
        ]])
    end
  },
  {"folke/tokyonight.nvim"},
  {
    "sainnhe/gruvbox-material",
    priority = 1001,
    config = function()
      -- Colorscheme
      vim.cmd([[
        syntax enable
        colorscheme gruvbox-material
        set background=dark
        " hi! Normal ctermbg=None guibg=None
        ]])
    end

  }
}
