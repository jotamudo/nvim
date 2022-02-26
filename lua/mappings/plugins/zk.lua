local set = vim.keymap.set
local zk = require('zk')

local opts = { noremap=true, silent=false }

-- Create a new note after asking for its title.
set("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
set("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
set("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

-- Search for the notes matching a given query.
set("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", opts)
-- Search for the notes matching the current visual selection.
set("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
