local feline = require('feline')
local gps = require('nvim-gps')
local devicons = require('nvim-web-devicons')

local colors = {
  bg = '#282828',
  black = '#1d2021',
  yellow = '#fabd2f',
  cyan = '#89b482',
  oceanblue = '#45707a',
  green = '#98971a',
  orange = '#d79921',
  violet = '#d3869b',
  magenta = '#b16286',
  white = '#a89984',
  fg = '#ebdbb2',
  skyblue = '#7daea3',
  red = '#cc241d',
}
gps.setup()


-- Plan:
-- [mode](evil-devil icon ) [filename] [gps] [lsp disgnostics]                                                         [git branch] [file percentage]
--
-- Adding component config
-- TODO: add component content
-- NOTE: lua is 1-indexed :(

-- function to get the same highlight on the bars and vi-icon
local vi_mode = require('feline.providers.vi_mode')
local vi_hl = function()
  return {
    name = vi_mode.get_mode_highlight_name(),
    fg = vi_mode.get_mode_color(),
    bg = colors.bg,
  }
end

-- Function to stylize file_info
local file_info_color = function(follow_vi_mode_color)
  local filename = vim.fn.expand('%:t')
  local extension = vim.fn.expand('%:e')
  local icon, color = devicons.get_icon_colors(filename, extension)
  return {
    bg = colors.black,
    -- lua weird () ? : syntax
    fg = vi_mode.get_mode_highlight_name():match('Normal?') and color or vi_mode.get_mode_color()
  }
end

-- components definition
local comps = {
  border = {
    provider = '▊',
    hl = vi_hl
  },
  space = {
    provider = ' '
  },
  vi_mode = {
    provider = ' ',
    -- provider = ' ',
    hl = vi_hl,
    left_sep = 'left_rounded',
    right_sep = 'right_rounded',
    icon = ''
  },
  file_info = {
    provider = 'file_info',
    left_sep = 'left_rounded',
    hl = file_info_color
  },
  position = {
    provider = 'position',
    hl = file_info_color
  },
  file_size = {
    provider = 'file_size',
    right_sep = 'right_rounded',
    hl = file_info_color
  },
  file_sep = {
    provider = '|',
    -- left_sep = 'slant_right',
    hl = {
      fg = colors.white,
      bg = colors.black
    }
  },
  file_encoding = {
    provider = 'file_encoding',
    hl = {
      fg = colors.cyan,
      bg = colors.black,
    }
  },
  diagnostic_info_count = {
    provider = 'diagnostic_info',
    hl = {
      fg = colors.white,
      bg = colors.black,
    }
  },
  diagnostic_hints = {
    provider = 'diagnostic_hints',
    hl = {
      fg = colors.skyblue,
    },
    left_sep = 'left_rounded',
  },
  diagnostic_warnings = {
    provider = 'diagnostic_warnings',
    hl = {
      fg = colors.yellow,
    },
  },
  diagnostic_errors = {
    provider = 'diagnostic_errors',
    hl = {
      fg = colors.red,
    },
    enabled = function()
      return require('feline.providers.lsp').diagnostics_exist()

    end,
    right_sep = 'right_rounded',
  },
  gps = {
    provider = function()
      return gps.get_location()
    end,
    enabled = function()
      return gps.is_available()
    end,
    hl = {
      fg = colors.green,
    },
    left_sep = 'left_rounded',
    right_sep = 'right_rounded',
  },
  ls_names = {
    provider = 'lsp_client_names',
    hl = {
      fg = colors.violet,
      bg = colors.black
    },
    left_sep = 'left_rounded',
    right_sep = 'right_rounded',
  },
  git = {
    provider = 'git_branch',
    hl = {
      fg = colors.green
    }
  },
  line_percentage = {
    provider = 'line_percentage',
    hl = {
      fg = colors.white
    }
  },
  scroll_bar = {
    provider = 'scroll_bar',
    hl = {
      fg = colors.cyan
    }
  },
}


-- components.active[3][1] = {
--   provider = "git_branch",
--   hl = {
--     fg = 'white',
--     bg = 'black',
--     style = 'bold'
--   },
--   right_sep = {
--     str = ' ',
--     hl = {
--       fg = 'NONE',
--       bg = 'black'
--     }
--   }
-- }

-- Insert 3 sections (left, middle, right) on active statusline
-- Insert 2 sections (left, right) on inactive statusline
local components = {
  active = {
    { -- left
      comps.border,
      comps.vi_mode,
      comps.file_info,
      comps.file_sep,
      comps.position,
      comps.file_sep,
      comps.file_size,
      comps.space,
      comps.ls_names,
      comps.diagnostic_hints,
      comps.diagnostic_warnings,
      comps.diagnostic_errors,
      comps.space,
    },
    { -- middle
      comps.gps,
    },
    {},
    { -- right
    comps.git,
    comps.file_encoding,
    comps.space,
    comps.line_percentage,
    comps.scroll_bar,
    comps.border,
    }
  },
  inactive = {
    { -- left
      comps.file_info,
      comps.file_sep,
      comps.position,
      comps.file_sep,
      comps.file_size,
      comps.space,
      comps.ls_names,
    },
    { -- right
    comps.git,
    }
  }
}

feline.setup{
  components = components,
  theme = colors
}
