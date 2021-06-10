require('nvim_utils')

local mappings = {
  ["n<leader>gb"] = {":GitBlameToggle<CR>", noremap = true}
}
nvim_apply_mappings(mappings)
