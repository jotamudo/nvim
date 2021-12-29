local cmp = require('cmp')
local nnoremap = require('astronauta.keymap').nnoremap

nnoremap { '<C-b>',     cmp.mapping.scroll_docs(-4) }
nnoremap { '<C-f>',     cmp.mapping.scroll_docs(4)  }
nnoremap { '<C-Space>', cmp.mapping.complete()      }
