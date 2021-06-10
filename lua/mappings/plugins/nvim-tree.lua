local utils = require('nvim_utils')

local mappings = {
    ["n<leader>e"] = {":NvimTreeToggle<CR>", noremap = true}
}
nvim_apply_mappings(mappings)
