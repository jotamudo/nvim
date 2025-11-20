-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local count_table_entries = function (T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

return {
    {
        '<leader>o',
        function()
            vim.diagnostic.open_float()
        end,
    },
    {
        '[e',
        function()
            if count_table_entries(vim.diagnostic.count(0)) > 0 then
                vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_prev() })
            end
        end,
    },
    {
        ']e',
        function()
            if count_table_entries(vim.diagnostic.count(0)) > 0 then
                vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_next() })
            end
        end,
    },
    {
        '<leader>q',
        function()
            vim.diagnostic.setloclist()
        end,
    },
    {
        'gD',
        function()
            vim.lsp.buf.declaration()
        end,
    },
    {
        'gd',
        function()
            vim.lsp.buf.definition()
        end,
    },
    {
        'K',
        function()
            vim.lsp.buf.hover()
        end,
    },
    {
        'gi',
        function()
            vim.lsp.buf.implementation()
        end,
    },
    {
        '<leader>K',
        function()
            vim.lsp.buf.signature_help()
        end,
    },
    {
        '<leader>wa',
        function()
            vim.lsp.buf.add_workspace_folder()
        end,
    },
    {
        '<leader>wr',
        function()
            vim.lsp.buf.remove_workspace_folder()
        end,
    },
    {
        '<leader>wl',
        function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
    },
    {
        '<leader>D',
        function()
            vim.lsp.buf.type_definition()
        end,
    },
    {
        '<leader>rn',
        function()
            vim.lsp.buf.rename()
        end,
    },
    {
        '<leader>ga',
        function()
            vim.lsp.buf.code_action()
        end,
    },
    {
        '<leader>gl',
        function()
            vim.lsp.codelens.run()
        end,
    },
    {
        '<leader>gf',
        function()
            vim.lsp.buf.format()
        end,
    },
    {
        '<leader>gv',
        function()
            vim.g.inlay_hints_visible = not vim.g.inlay_hints_visible
            vim.lsp.inlay_hint.enable(vim.g.inlay_hints_visible)
        end,
    },
    {
        'gr',
        function()
            vim.lsp.buf.references()
        end,
    },
}
