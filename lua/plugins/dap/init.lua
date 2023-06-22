return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", config = true },
			"rcarriga/cmp-dap",
			"jay-babu/mason-nvim-dap.nvim",
			"williamboman/mason.nvim",
		},
		keys = require("plugins.dap.mappings"),
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local mason_nvim_dap = require('mason-nvim-dap')
			mason_nvim_dap.setup({
				automatic_setup = true,
				automatic_installation = true,
			})
		end,
	},
}
