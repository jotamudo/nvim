local utils = require("nvim_utils")

local mappings = {
  -- HACK: Figure out another keybing for formatting buffer
  ["n<leader>bf"] = {"<cmd>Format<cr>", silent = true, noremap = true}
}

nvim_apply_mappings(mappings)
