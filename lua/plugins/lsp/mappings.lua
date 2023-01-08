  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
return {
  {'<leader>o', function() vim.diagnostic.open_float() end},
  {'[e', function() vim.diagnostic.goto_prev() end},
  {']e', function() vim.diagnostic.goto_next() end},
  {'<leader>q', function() vim.diagnostic.setloclist() end},
  {'gD', function() vim.lsp.buf.declaration() end},
  {'gd', function() vim.lsp.buf.definition() end},
  {'K', function() vim.lsp.buf.hover() end},
  {'gi', function() vim.lsp.buf.implementation() end},
  {'<leader>K', function() vim.lsp.buf.signature_help() end},
  {'<leader>wa', function() vim.lsp.buf.add_workspace_folder() end},
  {'<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end},
  {'<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end},
  {'<leader>D', function() vim.lsp.buf.type_definition() end},
  {'<leader>rn', function() vim.lsp.buf.rename() end},
  {'<leader>ga', function() vim.lsp.buf.code_action() end},
  {'gr', function() vim.lsp.buf.references() end},
}
