return {
    'mickael-menu/zk-nvim',
    dependencies = { 'dkarter/bullets.vim' },
    keys = require('mappings/plugins/zk'),
    config = function()
        require('zk').setup({
            -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
            -- it's recommended to use "telescope" or "fzf"
            picker = 'telescope',
            lsp = {
                -- `config` is passed to `vim.lsp.start_client(config)`
                config = {
                    cmd = { 'zk', 'lsp' },
                    name = 'zk',
                    -- on_attach = ...
                    -- etc, see `:h vim.lsp.start_client()`
                },
                -- automatically attach buffers in a zk notebook that match the given filetypes
                auto_attach = {
                    enabled = true,
                    filetypes = { 'markdown', 'pandoc' },
                },
            },
        })

        vim.cmd([[
    let g:markdown_enable_insert_mode_mappings = 0
    " Bullets.vim
    let g:bullets_enabled_file_types = [
        \ 'markdown',
        \ 'pandoc',
        \ 'text',
        \ 'gitcommit',
        \ 'scratch'
        \]
    ]])
    end,
}
