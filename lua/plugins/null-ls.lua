return {
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jayp0521/mason-null-ls.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		config = true,
	},
	{
		"jayp0521/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local mason_null_ls = require("mason-null-ls")
			mason_null_ls.setup({
        ensure_installed = { 'stylua', 'clang_format', 'yamlfix', 'yamlfmt', 'eslint'},
				automatic_installation = false,
				automatic_setup = true, -- Recommended, but optional
				handlers = {
					-- function() end, -- disables automatic setup of all null-ls sources
					-- stylua = function(source_name, methods)
					-- 	null_ls.register(null_ls.builtins.formatting.stylua)
					-- end,
					-- shfmt = function(source_name, methods)
					-- 	-- custom logic
					-- 	require("mason-null-ls").default_setup(source_name, methods) -- to maintain default behavior
					-- end,
				},
			})
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.completion.spell,
					require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
				},
			})
		end,
	},
}
