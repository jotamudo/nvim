local set = vim.keymap.set

local opts = { noremap = true}
set("v", "<leader>re", function() require('refactoring').refactor('Extract Function') end, opts)
set("v", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end, opts)
set("v", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end, opts)
set("v", "<leader>ri", function() require('refactoring').refactor('Inline Variable') end, opts)
set("n", "<leader>ri", function() require('refactoring').refactor('Inline Variable') end, opts)
-- call telescope prompt to decide action
set("v", "<leader>rt", function() require('telescope').extensions.refactoring.refactors() end, opts)

-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
set( "n", "<leader>rp", function() require('refactoring').debug.printf({below = false})end, opts)

-- Print var: this remap should be made in visual mode
set("v", "<leader>rv", function() require('refactoring').debug.print_var({}) end, opts)

-- Cleanup function: this remap should be made in normal mode
set("n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end, opts)
