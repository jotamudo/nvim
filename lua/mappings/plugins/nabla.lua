local set = vim.keymap.set

set('n', '<Leader>no', function() require('nabla').action() end )
set('n', '<Leader>np', function() require('nabla').popup() end )
