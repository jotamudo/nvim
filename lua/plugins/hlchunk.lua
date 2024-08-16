return {
  "shellRaining/hlchunk.nvim",
  event = { "UIEnter" },
  config = function()
    require('hlchunk').setup({
      chunk = {
        enable = true,
        use_treesitter = true,
        style = {
            { fg = "#d3869b" },
        },
        chars = {
          -- horizontal_line = "━",
          -- vertical_line = "┃",
          -- left_top = "┏",
          -- left_bottom = "┗",
          -- right_arrow = "━",
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        -- duration = 200,
        -- delay = 300,
        delay = 0,
      },
      blank = {
        enable = false,
      },
      line_num = {
        enable = true,
        use_treesitter = true,
      },
    })
  end
}
