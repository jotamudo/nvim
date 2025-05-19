return {
    {
        'nvimtools/none-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'jayp0521/mason-null-ls.nvim',
            'nvimtools/none-ls-extras.nvim',
        },
        -- config = true,
    },
    {
        'jayp0521/mason-null-ls.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'nvimtools/none-ls.nvim',
            'nvimtools/none-ls-extras.nvim',
        },
        lazy = false,
        config = function()
            local mason_null_ls = require('mason-null-ls')
            local null_ls = require('null-ls')
            mason_null_ls.setup({
                ensure_installed = {
                    'stylua',
                    'clang_format',
                    'yamlfix',
                    'yamlfmt',
                    'eslint',
                    'ruff',
                },
                automatic_installation = false,
                automatic_setup = true, -- Recommended, but optional
                handlers = {
                    function(source_name, methods)
                        -- custom logic
                        require('mason-null-ls').default_setup(
                            source_name,
                            methods
                        ) -- to maintain default behavior
                    end,
                    -- function() end, -- disables automatic setup of all null-ls sources
                    stylua = function(source_name, methods)
                        null_ls.register(null_ls.builtins.formatting.stylua)
                    end,
                    shfmt = function(source_name, methods)
                        -- custom logic
                        require('mason-null-ls').default_setup(
                            source_name,
                            methods
                        ) -- to maintain default behavior
                    end,
                    ruff = function(source_name, methods)
                        -- custom logic
                        require('mason-null-ls').default_setup(
                            source_name,
                            methods
                        ) -- to maintain default behavior
                    end,
                },
            })
            null_ls.setup({
                sources = {
                    null_ls.builtins.completion.spell,
                    require('none-ls.formatting.ruff_format'), -- requires none-ls-extras.nvim
                    require('none-ls.diagnostics.ruff'), -- requires none-ls-extras.nvim
                    require('none-ls.diagnostics.eslint'), -- requires none-ls-extras.nvim
                    -- require('none-ls.diagnostics.cpplint'), -- requires none-ls-extras.nvim
                    require('none-ls.code_actions.eslint'), -- requires none-ls-extras.nvim
                },
            })
        end,
    },
}
