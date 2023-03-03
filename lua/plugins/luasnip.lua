return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"honza/vim-snippets",
	},
	keys = {
		{
			"<tab>",
			function()
				return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
			end,
			expr = true,
			silent = true,
			mode = "i",
		},
		{
			"<tab>",
			function()
				require("luasnip").jump(1)
			end,
			mode = "s",
		},
		{
			"<s-tab>",
			function()
				require("luasnip").jump(-1)
			end,
			mode = { "i", "s" },
		},
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_snipmate").lazy_load()

		local types = require("luasnip.util.types")
		local ls = require("luasnip")
		local set = vim.keymap.set

		ls.config.setup({
			-- Remember last snippet and let me go back to it even if outside selection
			history = true,
			-- updating as I type
			updateevents = "TextChanged, TextChangedI",
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { "●", "GruvboxOrange" } },
					},
				},
				[types.insertNode] = {
					active = {
						virt_text = { { "●", "GruvboxBlue" } },
					},
				},
			},
		})

		set("i", "<c-l>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end)

		set("i", "<c-h>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end)

		-- go back to last snippet or last position on snippet
		set("i", "<c-k>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end)

		set("i", "<c-j>", function()
			if ls.jumpable(1) then
				ls.jump(1)
			end
		end)
	end,
}
