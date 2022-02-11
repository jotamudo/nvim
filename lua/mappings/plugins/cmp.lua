local cmp = require('cmp')
local set = vim.keymap.set-- use core keymapping function

-- nnoremap { '<C-b>',     function() cmp.mapping.scroll_docs(-4) end           }
-- nnoremap { '<C-f>',     function() cmp.mapping.scroll_docs(4) end            }
-- nnoremap { '<C-Space>', function() cmp.mapping.complete() end                }
-- nnoremap { '<CR>'     , function() cmp.mapping.confirm({ select = true}) end } -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
-- has to be defined on cmp.setup() :/
