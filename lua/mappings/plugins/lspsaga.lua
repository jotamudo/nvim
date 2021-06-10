local utils = require('nvim_utils')

local mappings = {
    ["ngd"]         = {"<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", silent = true, noremap = true},
    ["n<leader>ga"] = {"<cmd>lua require('lspsaga.codeaction').code_action()<CR>", silent = true, noremap = true},
    ["v<leader>ga"] = {":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", silent = true, noremap = true},
    ["nK"]          = {"<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", silent = true, noremap = true},
    ["n<C-f>"]      = {"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", silent = true, noremap = true},
    ["n<C-b>"]      = {"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", silent = true, noremap = true},
    ["ngs"]         = {"<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", silent = true, noremap = true},
    ["ngr"]         = {"<cmd>lua require('lspsaga.rename').rename()<CR>", silent = true, noremap = true},
    ["ngp"]         = {"<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", silent = true, noremap = true},
    ["ngl"]         = {"<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", silent = true, noremap = true},
    ["ngD"]         = {"<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>", silent = true, noremap = true},
    ["n[e"]         = {"<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", silent = true, noremap = true},
    ["n]e"]         = {"<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", silent = true, noremap = true},
    ["n<C-t>"]      = {"<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>", silent = true, noremap = true},
    ["t<C-t>"]      = {"<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>", silent = true, noremap = true},
    ["ngi"]         = {"<cmd>lua vim.lsp.buf.implementation()<CR>", silent = true, noremap = true}
}
nvim_apply_mappings(mappings)
