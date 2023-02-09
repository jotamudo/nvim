local set = vim.keymap.set
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

-- Quick save disable to leave space for vimwiki
-- ["n<leader>w"] = {":w!<CR>", noremap = true,},
-- Quick :nohlsearch
set("n", "<leader><CR>", ":nohlsearch<CR>", { silent = true })
set("i", "jk", "<ESC>", { silent = true, noremap = true })
set("i", "kj", "<ESC>", { silent = true, noremap = true })
-- Searching for highlighted text on visual mode
set("v", "*", ":<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>", { silent = true })
set("v", "#", ":<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>", { silent = true })
-- Quick window hopping
set("n", "<C-j>", "<C-w>j", { silent = true, noremap = true })
set("n", "<C-k>", "<C-w>k", { silent = true, noremap = true })
set("n", "<C-l>", "<C-w>l", { silent = true, noremap = true })
set("n", "<C-h>", "<C-w>h", { silent = true, noremap = true })
-- Move text with C-A-[hjkl]
set("n", "<C-A-j>", "mz:m+<cr>`z", { silent = true })
set("n", "<C-A-k>", "mz:m-2<cr>`z", { silent = true })
set("v", "<C-A-j>", ":m'>+<cr>`<my`>mzgv`yo`z", { silent = true })
set("v", "<C-A-k>", ":m'>-2<cr>`<my`>mzgv`yo`z", { silent = true })

vim.api.nvim_set_keymap("n", "<Leader><Space>", ":set hlsearch!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
