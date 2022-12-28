local set = vim.keymap.set
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
set('n', '<leader>o', function() vim.diagnostic.open_float() end)
set('n', '[e', function() vim.diagnostic.goto_prev() end)
set('n', ']e', function() vim.diagnostic.goto_next() end)
set('n', '<leader>q', function() vim.diagnostic.setloclist() end)
set('n', 'gD', function() vim.lsp.buf.declaration() end)
set('n', 'gd', function() vim.lsp.buf.definition() end)
set('n', 'K', function() vim.lsp.buf.hover() end)
set('n', 'gi', function() vim.lsp.buf.implementation() end)
set('n', '<leader>K', function() vim.lsp.buf.signature_help() end)
set('n', '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end)
set('n', '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end)
set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
set('n', '<leader>D', function() vim.lsp.buf.type_definition() end)
set('n', '<leader>rn', function() vim.lsp.buf.rename() end)
set('n', '<leader>ga', function() vim.lsp.buf.code_action() end)
set('n', 'gr', function() vim.lsp.buf.references() end)
-- deprecated as format is now default for formatprg
--set('n', '<leader>gf', function() vim.lsp.buf.formatting() end)
