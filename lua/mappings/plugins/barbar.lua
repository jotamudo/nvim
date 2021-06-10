local utils = require('nvim_utils')

local mappings = {
    ["n<leader>b,"]    = {":BufferPrevious<CR>",         silent = true, noremap = true},
    ["n<leader>b."]    = {":BufferNext<CR>",             silent = true, noremap = true},
    ["n<leader>b<"]    = {":BufferMovePrevious<CR>",     silent = true, noremap = true},
    ["n<leader>b>"]    = {":BufferMoveNext<CR>",         silent = true, noremap = true},
    ["n<leader>b1"]    = {":BufferGoto 1<CR>",           silent = true, noremap = true},
    ["n<leader>b2"]    = {":BufferGoto 2<CR>",           silent = true, noremap = true},
    ["n<leader>b3"]    = {":BufferGoto 3<CR>",           silent = true, noremap = true},
    ["n<leader>b4"]    = {":BufferGoto 4<CR>",           silent = true, noremap = true},
    ["n<leader>b5"]    = {":BufferGoto 5<CR>",           silent = true, noremap = true},
    ["n<leader>b6"]    = {":BufferGoto 6<CR>",           silent = true, noremap = true},
    ["n<leader>b7"]    = {":BufferGoto 7<CR>",           silent = true, noremap = true},
    ["n<leader>b8"]    = {":BufferGoto 8<CR>",           silent = true, noremap = true},
    ["n<leader>b9"]    = {":BufferGoto 9<CR>",           silent = true, noremap = true},
    ["n<leader>bc"]    = {":BufferClose<CR>",            silent = true, noremap = true},
    ["n<leader>bs"]    = {":BufferPick<CR>",             silent = true, noremap = true},
    ["n<leader>bd"] = {":BufferOrderByDirectory<CR>", silent = true, noremap = true},
    ["n<leader>bl"] = {":BufferOrderByLanguage<CR>",  silent = true, noremap = true},
}
nvim_apply_mappings(mappings)
