return {
    { '<leader>tx', '<cmd>Trouble<cr>' },
    { '<leader>tw', '<cmd>Trouble lsp_workspace_diagnostics<cr>' },
    { '<leader>td', '<cmd>Trouble lsp_document_diagnostics<cr>' },
    { '<leader>tl', '<cmd>Trouble loclist<cr>' },
    { '<leader>tq', '<cmd>Trouble quickfix<cr>' },
    -- Could use leader but it's better to leave g for git later
    { 'gR', '<cmd>Trouble lsp_references<cr>' },
}
