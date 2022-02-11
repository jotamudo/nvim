local set = vim.keymap.set
local neogit = require('neogit')

set( 'n', '<leader>gg', function() neogit.open() end)
set( 'n', '<leader>gc', function() neogit.open({ 'commit'}) end)
