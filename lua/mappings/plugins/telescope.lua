local utils = require('nvim_utils')

local mappings = {
  ["n<leader>ff"] = {"<cmd>lua require('telescope.builtin').find_files()<cr>", noremap = true},
  ["n<leader>fg"] = {"<cmd>lua require('telescope.builtin').live_grep()<cr>", noremap = true},
  ["n<leader>fb"] = {"<cmd>lua require('telescope.builtin').buffers()<cr>", noremap = true},
  ["n<leader>fh"] = {"<cmd>lua require('telescope.builtin').help_tags()<cr>", noremap = true},
  ["n<leader>fs"] = {"<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", noremap = true},
}
nvim_apply_mappings(mappings)





