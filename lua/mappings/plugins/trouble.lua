local utils = require('nvim_utils')

local mappings = {
  ["n<leader>tx"] = {"<cmd>Trouble<cr>", silent = true, noremap = true},
  ["n<leader>tw"] = {"<cmd>Trouble lsp_workspace_diagnostics<cr>", silent = true, noremap = true},
  ["n<leader>td"] = {"<cmd>Trouble lsp_document_diagnostics<cr>", silent = true, noremap = true},
  ["n<leader>tl"] = {"<cmd>Trouble loclist<cr>", silent = true, noremap = true},
  ["n<leader>tq"] = {"<cmd>Trouble quickfix<cr>", silent = true, noremap = true},
  -- Could use leader but it's better to leave g for git later
  ["ngR"]         = {"<cmd>Trouble lsp_references<cr>", silent = true, noremap = true},
}

nvim_apply_mappings(mappings)
