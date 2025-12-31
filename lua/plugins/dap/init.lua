return {
    {
        'mfussenegger/nvim-dap',
        event = 'VeryLazy',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                config = true,
                dependencies = { 'nvim-neotest/nvim-nio' },
            },
            -- "rcarriga/cmp-dap",
            'jay-babu/mason-nvim-dap.nvim',
            'williamboman/mason.nvim',
        },
        keys = require('plugins.dap.mappings'),
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'mfussenegger/nvim-dap-python',
        },
        config = function()
            local mason_nvim_dap = require('mason-nvim-dap')
            mason_nvim_dap.setup({
                ensure_installed = { 'codelldb', 'python', 'kotlin', 'dart' },
                automatic_setup = true,
                automatic_installation = true,
                handlers = {
                    function(config)
                        -- all sources with no handler get passed here
                        -- Keep original functionality
                        require('mason-nvim-dap').default_setup(config)
                    end,
                    -- dart = function (config)
                    -- 	config.adapters = {
                    -- 		type = "executable",
                    -- 		command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
                    -- 		args = {"flutter"}
                    -- 	}
                    -- end
                },
            })
        end,
    },
}
