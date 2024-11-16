local capabilities = vim.tbl_deep_extend(
	"force",
	{},
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities() or {}
)

local custom_attach = function(client, bufnr)
	-- inlay hints for clangd

	-- if client.server_capabilities.inlayHintProvider then
	--   vim.lsp.inlay_hints(0, true)
	-- end
	if client.server_capabilities.inlayHintProvider then
		vim.g.inlay_hints_visible = true
		vim.lsp.inlay_hint.enable()
	else
		-- print("no inlay hints available")
	end

	vim.lsp.codelens.display(vim.lsp.codelens.get(bufnr), bufnr, client.id)

	local on_lsp_attach = vim.api.nvim_create_augroup("OnLspAttach", { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
		pattern = "*",
		callback = function(_ev)
			vim.lsp.codelens.refresh({ bufnr = 0 })
		end,
		group = on_lsp_attach,
	})

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end

	-- disable highlight on big files
	local buf_name = vim.api.nvim_buf_get_name(bufnr)
	local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
	if file_size > 256 * 1024 then
		client.server_capabilities.semanticTokensProvider = nil
	end

	-- if client.name == "pyright" then
	--   client.server_capabilities.completionProvider = false
	-- end

	if client.name == "typescript-tools" and vim.bo.filetype == "vue" then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
	{ "williamboman/mason-lspconfig.nvim", event = "BufReadPre", config = true },
	{
		url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = { "BufReadPre" },
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config({ virtual_text = false })
			local ll = require("lsp_lines")
			ll.setup()
			vim.keymap.set("n", "<leader>l", ll.toggle, { silent = true, desc = "Toggle [L]ines" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						vim.env.VIMRUNTIME,
						"nvim-cmp/lua/cmp/types",
						-- Or relative, which means they will be resolved from the plugin dir.
						"lazy.nvim",
						"luvit-meta/library",
						-- It can also be a table with trigger words / mods
						-- Only load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
						-- Load the wezterm types when the `wezterm` module is required
						-- Needs `justinsgithub/wezterm-types` to be installed
						{ path = "wezterm-types", mods = { "wezterm" } },
						-- Load the xmake types when opening file named `xmake.lua`
						-- Needs `LelouchHe/xmake-luals-addon` to be installed
						{ path = "xmake-luals-addon/library", files = { "xmake.lua" } },
						{ plugins = { "nvim-dap-ui" }, types = true },
					},
					-- always enable unless `vim.g.lazydev_enabled = false`
					-- This is the default
					enabled = function(root_dir)
						return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
					end,
					-- disable when a .luarc.json file is found
					-- enabled = function(root_dir)
					--   return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
					-- end,
				},
				dependencies = { "justinsgithub/wezterm-types", "LelouchHe/xmake-luals-addon" },
			},
			"p00f/clangd_extensions.nvim",
			{
				"williamboman/mason.nvim",
				lazy = false,
				opts = {
					registries = {
						"github:mason-org/mason-registry",
					},
				},
			},
			{
				"mrcjkb/rustaceanvim",
				-- version = '^5', -- Recommended
				init = function()
					local rust_capabilities = vim.tbl_extend("force", vim.deepcopy(capabilities), {
						textDocument = {
							completion = {
								completionItem = {
									snippetSupport = false,
								},
							},
						},
						experimental = {
							hoverActions = true,
							colorDiagnosticOutput = true,
							hoverRange = true,
							serverStatusNotification = true,
							snippetTextEdit = false,
							codeActionGroup = true,
							ssr = true,
						},
					})
					vim.g.rustaceanvim = {
						server = {
							capabilities = rust_capabilities,
							on_attach = function(client, bufnr)
								if client.server_capabilities.inlayHintProvider then
									vim.g.inlay_hints_visible = true
									vim.lsp.inlay_hint.enable()
								else
									vim.print("no inlay hints available")
								end
								-- disable highlight on big files
								local buf_name = vim.api.nvim_buf_get_name(bufnr)
								local file_size = vim.api.nvim_call_function("getfsize", { buf_name })

								if file_size > 256 * 1024 then
									client.server_capabilities.semanticTokensProvider = nil
								end
							end,
						},
					}
				end,

				branch = "master",
				lazy = false, -- This plugin is already lazy
			},
			{ "SmiteshP/nvim-navic" },
			{
				"pmizio/typescript-tools.nvim",
				dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			},
			{
				-- NOTE: modified version of nvim-java, I need to sleep
				"jotamudo/nvim-java",
				dev = true,
				ft = "java",
				config = function()
					require("java").setup()
				end,
				dependencies = {
					"nvim-java/lua-async-await",
					"nvim-java/nvim-java-refactor",
					"nvim-java/nvim-java-core",
					"nvim-java/nvim-java-test",
					"nvim-java/nvim-java-dap",
					"MunifTanjim/nui.nvim",
					"neovim/nvim-lspconfig",
					"mfussenegger/nvim-dap",
					{
						"JavaHello/spring-boot.nvim",
						commit = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
					},
					{
						"williamboman/mason.nvim",
						opts = {
							registries = {
								"github:nvim-java/mason-registry",
								"github:mason-org/mason-registry",
							},
						},
					},
				},
			},
			{
				"nvim-flutter/flutter-tools.nvim",
				lazy = false,
				dependencies = {
					"nvim-lua/plenary.nvim",
					"stevearc/dressing.nvim",
				},
				opts = {
					debugger = {
						enabled = true,
						run_via_dap = true,
						register_configurations = function(_)
							require("dap").adapters.dart = {
								type = "executable",
								command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
								args = { "flutter" },
							}
							require("dap").configurations.dart = {
								{
									type = "dart",
									request = "launch",
									name = "Launch Flutter Program",
									-- The nvim-dap plugin populates this variable with the filename of the current buffer
									program = "${file}",
									-- The nvim-dap plugin populates this variable with the editor's current working directory
									cwd = "${workspaceFolder}",
									-- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
									toolArgs = { "-d", "linux" },
								},
							}
							require("dap.ext.vscode").load_launchjs()
						end,
					},
					lsp = {
						color = {
							enabled = true,
							background = true,
							background_color = { r = 19, g = 17, b = 24 },
							foreground = false,
							virtual_text = true,
							virtual_text_str = "■",
						},
						on_attach = custom_attach,
						capabilities = capabilities,
					},
				},
			},
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jubnzv/virtual-types.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		keys = require("plugins.lsp.mappings"),
		opts = {
			inlay_hints = {
				enabled = true,
			},
		},
		config = function()
			local original = vim.lsp.handlers["textDocument/publishDiagnostics"]
			vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
				vim.tbl_map(function(item)
					if item.relatedInformation and #item.relatedInformation > 0 then
						vim.tbl_map(function(k)
							if k.location then
								local tail = vim.fn.fnamemodify(vim.uri_to_fname(k.location.uri), ":t")
								k.message = tail
									.. "("
									.. (k.location.range.start.line + 1)
									.. ", "
									.. (k.location.range.start.character + 1)
									.. "):"
							end
							item.message = item.message .. "\n" .. k.message
						end, item.relatedInformation)
					end
				end, result.diagnostics)
				original(_, result, ctx, config)
			end

			local lspconfig = require("lspconfig")
			local configs = require("lspconfig.configs")
			local util = require("lspconfig.util")
			local env_vars = vim.fn.environ()

			vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
			vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

			local border = {
				{ "🭽", "FloatBorder" },
				{ "▔", "FloatBorder" },
				{ "🭾", "FloatBorder" },
				{ "▕", "FloatBorder" },
				{ "🭿", "FloatBorder" },
				{ "▁", "FloatBorder" },
				{ "🭼", "FloatBorder" },
				{ "▏", "FloatBorder" },
			}

			-- To instead override globally
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or border
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			-- change diagnostic symbols
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local icons = {
				Class = " ",
				Color = " ",
				Constant = " ",
				Constructor = " ",
				Enum = "了 ",
				EnumMember = " ",
				Field = " ",
				File = " ",
				Folder = " ",
				Function = " ",
				Interface = "ﰮ ",
				Keyword = " ",
				Method = "ƒ ",
				Module = " ",
				Property = " ",
				Snippet = "﬌ ",
				Struct = " ",
				Text = " ",
				Unit = " ",
				Value = " ",
				Variable = " ",
			}

			local kinds = vim.lsp.protocol.CompletionItemKind
			for i, kind in ipairs(kinds) do
				kinds[i] = icons[kind] or kind
			end

			-- customize diagnostic info
			vim.diagnostic.config({
				virtual_text = {
					source = "always",
					prefix = "●",
				},
				float = {
					source = "always",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = false,
			})

			-- show diagnostic on cursor on floating window
			vim.o.updatetime = 250
			vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])

			-- TODO: just do this deep extend on the default client capabilities
			-- vim.tbl_deep_extend(
			--   'force',
			--   vim.lsp.protocol.make_client_capabilities(),
			--   require('cmp_nvim_lsp').default_capabilities(),
			--   {
			--     workspace = {
			--       -- PERF: didChangeWatchedFiles is too slow.
			--       -- TODO: Remove this when https://github.com/neovim/neovim/issues/23291#issuecomment-1686709265 is fixed.
			--       didChangeWatchedFiles = { dynamicRegistration = false },
			--     },
			--   }
			-- )

			--Enable (broadcasting) snippet capability for completion
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.completion.completionItem.resolveSupport = {
				properties = { "documentation", "detail", "additionalTextEdits" },
			}

			-- See uses

			local clangd_capabilities = capabilities
			clangd_capabilities = {
				textDocument = {
					completion = {
						completionItem = {
							commitCharactersSupport = true,
							deprecatedSupport = true,
							insertReplaceSupport = true,
							labelDetailsSupport = true,
							preselectSupport = true,
							resolveSupport = {
								properties = { "documentation", "detail", "additionalTextEdits" },
							},
							snippetSupport = false,
							tagSupport = {
								valueSet = { 1 },
							},
						},
					},
				},
			}
			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--background-index",
					"--suggest-missing-includes",
					"--enable-config",
					"-j=8",
					"--malloc-trim",
					"--background-index",
					"--pch-storage=memory",
				},
				-- options to pass to nvim-lspconfig
				-- i.e. the arguments to require("lspconfig").clangd.setup({})
				on_attach = custom_attach,
				capabilities = clangd_capabilities,
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
				},
				flags = {
					debounce_text_changes = 150,
				},
			})

			if not configs.neocmake then
				configs.neocmake = {
					default_config = {
						cmd = { "neocmakelsp", "--stdio" },
						filetypes = { "cmake" },
						root_dir = function(fname)
							return lspconfig.util.find_git_ancestor(fname)
						end,
						single_file_support = true, -- suggested
						on_attach = custom_attach, -- on_attach is the on_attach function you defined
					},
				}
				lspconfig.neocmake.setup({})
			end

			lspconfig.bashls.setup({
				on_attach = custom_attach,
				flags = {
					debounce_text_changes = 150,
				},
			})

			-- lspconfig.pyright.setup {
			--   on_attach = custom_attach,
			--   flags = {
			--     debounce_text_changes = 150
			--   },
			--   settings = {
			--     python = {
			--       analysis = {
			--         typeCheckingMode = "off"
			--       }
			--     }
			--   }
			-- }

			if not configs.pylance then
				local root_files = {
					"pyproject.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					"Pipfile",
					"pyrightconfig.json",
					".git",
				}

				configs.pylance = {
					default_config = {
						cmd = { "delance-langserver", "--stdio" },
						filetypes = { "python" },
						root_dir = function(fname)
							return lspconfig.util.root_pattern(unpack(root_files))(fname)
						end,
						single_file_support = true, -- suggested
						on_attach = custom_attach, -- on_attach is the on_attach function you defined
					},
				}
			end

			lspconfig.pylance.setup({
				settings = {
					python = {
						pythonPath = "/usr/bin/python3",
						analysis = {
							inlayHints = {
								variableTypes = true,
								functionReturnTypes = true,
								callArgumentNames = true,
							},
						},
					},
				},
			})

			lspconfig.texlab.setup({
				on_attach = custom_attach,
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				},
			})

			lspconfig.jsonls.setup({
				on_attach = custom_attach,
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				},
			})

			lspconfig.vimls.setup({
				on_attach = custom_attach,
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				},
			})

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
						},
						format = { enable = false },
						hint = { enable = true },
					},
				},
			})

			-- C#
			local pid = vim.fn.getpid()
			local omnisharp_bin = "/usr/bin/omnisharp"

			lspconfig.omnisharp.setup({
				-- cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid)},
				-- flags = {
				--   debounce_text_changes = 150
				-- }
			})

			-- Web
			lspconfig.html.setup({
				on_attach = custom_attach,
				filetypes = { "html", "htmldjango" },
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				},
			})

			lspconfig.cssls.setup({
				on_attach = custom_attach,
				flags = {
					debounce_text_changes = 150,
				},
			})

			local extension_path = env_vars.HOME .. ".vscode-oss/extensions/vadimcn.vscode-lldb-1.6.10/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.completion.completionItem.resolveSupport = {
				properties = { "documentation", "detail", "additionalTextEdits" },
			}

			-- if not configs.hdl_checker then
			--   configs.hdl_checker = {
			--     default_config = {
			--       -- autostart = false, -- disabled auto start since I am giving rust_hdl a shot
			--       cmd = {"hdl_checker", "--lsp"};
			--       filetypes = { "vhdl", "verilog", "systemverilog" };
			--       root_dir = function(fname)
			--         return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
			--         -- return util.root_pattern('.hdl_checker.config')(fname) or util.path.dirname(fname)
			--       end;
			--       settings = {};
			--     };
			--   }
			-- end

			-- lspconfig.hdl_checker.setup{
			--   on_attach = custom_attach
			-- }

			lspconfig.vhdl_ls.setup({
				capabilities = capabilities,
				on_attach = custom_attach,
			})

			lspconfig.lemminx.setup({
				on_attach = custom_attach,
				settings = {
					xml = {
						catalogs = { "/etc/xml/catalog" },
					},
				},
			})

			-- lspconfig.vuels.setup({
			--   on_attach = custom_attach,
			--   completion = {
			--     autoImport = false,
			--   },
			--   format = {
			--     defaultFormatter = {
			--         js = 'eslint',
			--         -- ts = 'none',
			--       },
			--   }
			-- })
			--

			local function read_json_file(filename)
				local Path = require("plenary.path")

				local path = Path:new(filename)
				if not path:exists() then
					return nil
				end

				local json_contents = path:read()
				local json = vim.fn.json_decode(json_contents)

				return json
			end

			local function read_package_json()
				return read_json_file("package.json")
			end

			local function is_npm_package_installed(package)
				local package_json = read_package_json()
				if not package_json then
					return false
				end

				if package_json.dependencies and package_json.dependencies[package] then
					return true
				end

				if package_json.devDependencies and package_json.devDependencies[package] then
					return true
				end

				return false
			end

			local function get_typescript_server_path(root_dir)
				local global_ts = "/home/"
					.. env_vars.USER
					.. "/.nvm/versions/node/v20.12.2/lib/node_modules/typescript/lib"
				-- Alternative location if installed as root:
				-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
				local found_ts = ""
				local function check_dir(path)
					found_ts = util.path.join(path, "node_modules", "typescript", "lib")
					if util.path.exists(found_ts) then
						return path
					end
				end
				if util.search_ancestors(root_dir, check_dir) then
					return found_ts
				else
					return global_ts
				end
			end

			local vue_filetypes = { "vue" }
			-- local have_vue = is_npm_package_installed('vue')
			local have_vue = false -- apparently volar doesn't wrap around tsserver anymore?
			if not have_vue then
				vue_filetypes = { "vue", "typescript", "javascript", "typescriptreact" }
			end

			lspconfig.volar.setup({
				on_attach = custom_attach,
				-- filetypes = vue_filetypes,
				capabilities = capabilities,
				on_new_config = function(new_config, new_root_dir)
					new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
				end,
				settings = {
					typescript = {
						preferences = {
							importModuleSpecifier = "non-relative",
						},
					},
					vue = {
						complete = {
							casing = {
								props = "autoCamel",
							},
						},
					},
				},
			})

			if not have_vue then
				require("typescript-tools").setup({
					on_attach = custom_attach,
					flags = {
						debounce_text_changes = 150,
					},
					init_options = {
						-- plugins = {
						--   {
						--     name = "@vue/typescript-plugin",
						--     -- location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
						--     location = "/home/j_mudo/.nvm/versions/node/v20.12.2/lib/node_modules/@vue/typescript-plugin",
						--     languages = { "javascript", "typescript", "vue" },
						--   },
						-- },
					},
					filetypes = {
						"javascript",
						"typescript",
						"vue",
					},
					settings = {
						tsserver_plugins = {
							-- for TypeScript v4.9+
							"@styled/typescript-styled-plugin",
							-- or for older TypeScript versions
							-- "typescript-styled-plugin",
							"@vue/typescript-plugin",
							"@volar/vue-language-server",
						},
						expose_as_code_action = "all",
						complete_function_calls = true,
					},
				})
			end

			lspconfig.svlangserver.setup({
				on_attach = custom_attach,
				filetypes = { "verilog", "systemverilog" },
				settings = {
					systemverilog = {
						includeIndexing = { "*.{v,vh,sv,svh}", "**/*.{v,vh,sv,svh}", "**/**/*.{v,vh,sv,svh}" },
						-- excludeIndexing     = {"test/**/*.sv*"},
						-- defines             = {},
						-- launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
						linter = "verilator",
						formatCommand = "verible-verilog-format --indentation_spaces=4",
					},
				},
			})

			lspconfig.jdtls.setup({})
			lspconfig.groovyls.setup({
				cmd = { "groovy-language-server" },
			})

			lspconfig.kotlin_language_server.setup({
				on_attach = custom_attach,
				capabilities = capabilities,
			})

			-- EXPERIMENTAL

			-- lacks inlay hints feature
			-- lspconfig.ccls.setup {
			--   on_attach = custom_attach,
			--   capabilities = {
			--     textDocument = {
			--       completion = {
			--         completionItem = {
			--           snippetSupport = true
			--         }
			--       }
			--     }
			--   },
			-- }
		end,
	},
}
