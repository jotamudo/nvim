local utils = require('nvim_utils')

local mappings = {
  ["n<leader>xx"] = {"<cmd>Trouble<cr>", silent = true, noremap = true},
  ["n<leader>xw"] = {"<cmd>Trouble lsp_workspace_diagnostics<cr>", silent = true, noremap = true},
  ["n<leader>xd"] = {"<cmd>Trouble lsp_document_diagnostics<cr>", silent = true, noremap = true},
  ["n<leader>xl"] = {"<cmd>Trouble loclist<cr>", silent = true, noremap = true},
  ["n<leader>xq"] = {"<cmd>Trouble quickfix<cr>", silent = true, noremap = true},
  -- Could use leader but it's better to leave g for git later
  ["ngR"]         = {"<cmd>Trouble lsp_references<cr>", silent = true, noremap = true},
}

nvim_apply_mappings(mappings)
