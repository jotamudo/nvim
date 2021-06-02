require('nvim_utils')
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Helper functions

vim.cmd([[
function! CmdLine(str)
call feedkeys(":" . a:str)
endfunction 
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
]])

local mappings = {
    -- Quick save disable to leave space for vimwiki
    -- ["n<leader>w"] = {":w!<CR>", noremap = true,},
    -- Quick :nohlsearch
    ["n<leader><CR>"] = {":nohlsearch<CR>", silent = true},
    ["ijk"] = {"<ESC>", silent = true, noremap = true},
    ["ikj"] = {"<ESC>", silent = true, noremap = true},
    -- Searching for highlighted text on visual mode
    ["v*"] = {":<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>", silent = true},
    ["v#"] = {":<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>", silent = true},
    -- Quick window hopping
    ["n<C-j>"] = {"<C-w>j", silent = true, noremap = true},
    ["n<C-k>"] = {"<C-w>k", silent = true, noremap = true},
    ["n<C-l>"] = {"<C-w>l", silent = true, noremap = true},
    ["n<C-h>"] = {"<C-w>h", silent = true, noremap = true},
    -- Move text with C-A-[hjkl]
    ["n<C-A-j>"] = {"mz:m+<cr>`z", silent = true},
    ["n<C-A-k>"] = {"mz:m-2<cr>`z", silent = true},
    ["v<C-A-j>"] = {":m'>+<cr>`<my`>mzgv`yo`z", silent = true},
    ["v<C-A-k>"] = {":m'>-2<cr>`<my`>mzgv`yo`z", silent = true},
}

nvim_apply_mappings(mappings)

vim.api.nvim_set_keymap('n', '<Leader><Space>', ':set hlsearch!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })

