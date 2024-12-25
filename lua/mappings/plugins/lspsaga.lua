return {
    { 'gd', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>" },
    {
        '<leader>ga',
        "<cmd>lua require('lspsaga.codeaction').code_action()<CR>",
    },
    {
        '<leader>ga',
        ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>",
        mode = 'v',
    },
    { 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>" },
    {
        '<C-f>',
        "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
    },
    {
        '<C-b>',
        "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
    },
    { 'gs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>" },
    { 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>" },
    { 'gp', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>" },
    {
        'gl',
        "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>",
    },
    {
        'gD',
        "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>",
    },
    {
        '[e',
        "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",
    },
    {
        ']e',
        "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>",
    },
    {
        '<C-t>',
        "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>",
    },
    {
        '<C-t>',
        "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>",
        mode = 't',
    },
    { 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>' },
}
