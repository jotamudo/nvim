return {
  {
    "ellisonleao/gruvbox.nvim",
    -- enabled = false,
    priority = 1001,
    config = function()
    -- vim.api.nvim_set_hl(0, "StatusLine", {reverse = false})
    -- vim.api.nvim_set_hl(0, "StatusLineNC", {reverse = false})
      require("gruvbox").setup({
        invert = false,
      })

      -- vim.api.nvim_set_hl(0, "StatusLine", {reverse = false})
      -- vim.api.nvim_set_hl(0, "StatusLineNC", {reverse = false})

      vim.o.termguicolors = true
      vim.o.background = 'dark'
      vim.cmd.colorscheme('gruvbox')
      vim.cmd('hi! Normal ctermbg=None guibg=None')
    end
  },
  {"folke/tokyonight.nvim"},
  {
    "sainnhe/gruvbox-material",
    priority = 1001,
    -- enabled = false,
    config = function()
      -- -- Colorscheme
      -- vim.cmd([[
      --   syntax enable
      --   let g:gruvbox_material_background = 'hard'
      --   colorscheme gruvbox-material
      --   set background=dark
      --   hi! Normal ctermbg=None guibg=None
      --   ]])
    end

  },
  {
    'luisiacc/gruvbox-baby',
    priority = 1001,
    -- enabled = false,
    config = function()
      -- Colorscheme
    --   vim.cmd([[
    --     syntax enable
    --     colorscheme gruvbox-baby
    --     set background=dark
    --     hi! Normal ctermbg=None guibg=None
    --     ]])
    end
  },
  {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    -- vim.o.termguicolors = true
    -- vim.o.background = 'dark'
    require('solarized').setup(opts)
    -- vim.cmd.colorscheme 'solarized'
    -- vim.cmd("hi! Normal ctermbg=None guibg=None")
  end,
  }
}
