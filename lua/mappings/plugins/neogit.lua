local nnoremap = require('astronauta.keymap').nnoremap
local neogit = require('neogit')

nnoremap { '<leader>gg', function () neogit.open() end }
nnoremap { '<leader>gc', function () neogit.open({ 'commit' }) end }
