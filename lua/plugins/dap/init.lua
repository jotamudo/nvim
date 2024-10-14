return {
	{
		"mfussenegger/nvim-dap",
		lazy = false,
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				config = true,
				dependencies = {"nvim-neotest/nvim-nio"}
			},
			-- "rcarriga/cmp-dap",
			"jay-babu/mason-nvim-dap.nvim",
			"williamboman/mason.nvim",
		},
		keys = require("plugins.dap.mappings"),
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap-python"
		},
		config = function()
			local mason_nvim_dap = require('mason-nvim-dap')
			mason_nvim_dap.setup({
				automatic_setup = true,
				automatic_installation = true,
				-- handlers = {
				-- 	function(config)
				-- 		-- all sources with no handler get passed here
				--
				-- 		-- Keep original functionality
				-- 		require('mason-nvim-dap').default_setup(config)
				-- 	end,
				-- 	python = function(config)
				-- 		config.adapters = {
				-- 			type = "executable",
				-- 			command = "python",
				-- 			args = {
				-- 				"-m",
				-- 				"debugpy.adapter",
				-- 			},
				-- 		}
				-- 		require('mason-nvim-dap').default_setup(config) -- don't forget this!
				-- 	end,
				-- },
			})
		end,
	},
}
