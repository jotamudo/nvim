local set = vim.keymap.set
local telekasten = require('telekasten')

-- On hesitation, bring up the command panel
set('n', '<leader>z', function() telekasten.panel() end)

-- Function mappings
set('n', '<leader>zf', function() telekasten.find_notes() end)
set('n', '<leader>zd', function() telekasten.find_daily_notes() end)
set('n', '<leader>zg', function() telekasten.search_notes() end)
set('n', '<leader>zz', function() telekasten.follow_link() end)
set('n', '<leader>zT', function() telekasten.goto_today() end)
set('n', '<leader>zW', function() telekasten.goto_thisweek() end)
set('n', '<leader>zw', function() telekasten.find_weekly_notes() end)
set('n', '<leader>zn', function() telekasten.new_note() end)
set('n', '<leader>zN', function() telekasten.new_templated_note() end)
set('n', '<leader>zy', function() telekasten.yank_notelink() end)
set('n', '<leader>zc', function() telekasten.show_calendar() end)
set('n', '<leader>zC', '<cmd>:CalendarT<CR>')
set('n', '<leader>zi', function() telekasten.paste_img_and_link() end)
set('n', '<leader>zt', function() telekasten.toggle_todo() end)
set('n', '<leader>zb', function() telekasten.show_backlinks() end)
set('n', '<leader>zF', function() telekasten.find_friends() end)
set('n', '<leader>zI', function() telekasten.insert_img_link({ i=true }) end)
set('n', '<leader>zp', function() telekasten.preview_img() end)
set('n', '<leader>zm', function() telekasten.browse_media() end)
set('n', '<leader>za', function() telekasten.show_tags() end)
set('n', '<leader>#',  function() telekasten.show_tags() end)
set('n', '<leader>zr', function() telekasten.rename_note() end)

-- we could define [[ in **insert mode** to call insert link
-- inoremap [[ <cmd>:lua telekasten.insert_link()<CR>
-- alternatively: leader [
-- set('i', '<leader>[', telekasten.insert_link({ i=true }))
-- set('i', '<leader>zt', telekasten.toggle_todo({ i=true }))
-- set('i', '<leader>#', telekasten.show_tags({i = true}))

-- Search for urgent tag notes
set('n', '<leader>zU', function() telekasten.follow_link({follow_tag='#urgent'}) end)
