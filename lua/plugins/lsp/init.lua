return {
  { "williamboman/mason-lspconfig.nvim",
    config = true,
    -- opts = {
    --   automatic_installation = {'groovy-language-server'}
    -- }
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dependencies = "neovim/nvim-lspconfig",
    config = function ()
      vim.diagnostic.config({ virtual_text = false })
      local ll = require("lsp_lines")
      ll.setup()
      vim.keymap.set("n", "<leader>l", ll.toggle, {silent = true, desc = "Toggle [L]ines"})
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      {"folke/neoconf.nvim", cmd = "Neoconf", config = true},
      -- {"folke/neodev.nvim", config = true}, -- deprecated in favor of lazydev
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- Library paths can be absolute
            "~/projects/my-awesome-lib",
            -- Or relative, which means they will be resolved from the plugin dir.
            "lazy.nvim",
            "luvit-meta/library",
            -- It can also be a table with trigger words / mods
            -- Only load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
            -- always load the LazyVim library
            "LazyVim",
            -- Only load the lazyvim library when the `LazyVim` global is found
            { path = "LazyVim", words = { "LazyVim" } },
            -- Load the wezterm types when the `wezterm` module is required
            -- Needs `justinsgithub/wezterm-types` to be installed
            { path = "wezterm-types", mods = { "wezterm" } },
            -- Load the xmake types when opening file named `xmake.lua`
            -- Needs `LelouchHe/xmake-luals-addon` to be installed
            { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
          },
          -- always enable unless `vim.g.lazydev_enabled = false`
          -- This is the default
          enabled = function(root_dir)
            return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
          end,
          -- disable when a .luarc.json file is found
          enabled = function(root_dir)
            return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
          end,
        },
      },
      "p00f/clangd_extensions.nvim",
      "simrat39/rust-tools.nvim",
      "williamboman/mason.nvim",
      {"SmiteshP/nvim-navic"},
      {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      },
      {
        "brymer-meneses/grammar-guard.nvim",
        config = function()
          require("grammar-guard").init()
        end,
        ft = {"md", "latex"}
      },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jubnzv/virtual-types.nvim",
      "hrsh7th/cmp-nvim-lsp"
    },
    keys = require("plugins.lsp.mappings"),
    opts = {
      inlay_hints = {
        enabled = true
      }
    },
    config = function()

      local original = vim.lsp.handlers['textDocument/publishDiagnostics']
      vim.lsp.handlers['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
        vim.tbl_map(function(item)
          if item.relatedInformation and #item.relatedInformation > 0 then
            vim.tbl_map(function(k)
              if k.location  then
                local tail = vim.fn.fnamemodify(vim.uri_to_fname(k.location.uri),':t')
                k.message = tail ..'('..(k.location.range.start.line+1)..', ' .. (k.location.range.start.character + 1)..'):'
              end
              item.message = item.message .. '\n' .. k.message
            end, item.relatedInformation)
          end
        end, result.diagnostics)
        original(_, result, ctx, config)
      end

      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      local util = require("lspconfig.util")
      local env_vars = vim.fn.environ()

      vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
      vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

      local border = {
        {"🭽", "FloatBorder"},
        {"▔", "FloatBorder"},
        {"🭾", "FloatBorder"},
        {"▕", "FloatBorder"},
        {"🭿", "FloatBorder"},
        {"▁", "FloatBorder"},
        {"🭼", "FloatBorder"},
        {"▏", "FloatBorder"}
      }

      -- To instead override globally
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -- change diagnostic symbols
      local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
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
        Variable = " "
      }

      local kinds = vim.lsp.protocol.CompletionItemKind
      for i, kind in ipairs(kinds) do
        kinds[i] = icons[kind] or kind
      end

      -- customize diagnostic info
      vim.diagnostic.config(
        {
          virtual_text = {
            source = "always",
            prefix = "●"
          },
          float = {
            source = "always"
          },
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = false
        }
      )

      -- show diagnostic on cursor on floating window
      vim.o.updatetime = 250
      vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {"documentation", "detail", "additionalTextEdits"}
      }

      -- See uses
      local custom_attach = function(client, bufnr)
        -- require'lsp_signature'.on_attach()
        -- if client.server_capabilities.document_highlight then
        --   vim.cmd [[
        --       hi! LspReferenceRead cterm=bold ctermbg=red guibg=#282828
        --       hi! LspReferenceText cterm=bold ctermbg=red guibg=#282828
        --       hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#282828
        --       augroup lsp_document_highlight
        --         autocmd! * <buffer>
        --         autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        --         autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        --       augroup END
        --     ]]
        -- end

        -- inlay hints for clangd

        -- if client.server_capabilities.inlayHintProvider then
        --   vim.lsp.inlay_hints(0, true)
        -- end
        if client.server_capabilities.inlayHintProvider then
          vim.g.inlay_hints_visible = true
          vim.lsp.inlay_hint.enable()
        else
          print("no inlay hints available")
        end
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

        print("Lsp ready")
      end

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
                        properties = { "documentation", "detail", "additionalTextEdits" }
                    },
                    snippetSupport = false,
                    tagSupport = {
                        valueSet = { 1 }
                    }
                }
            }
        }
      }
      lspconfig.clangd.setup({
          cmd = {"clangd", "--background-index", "--suggest-missing-includes", "--enable-config", "-j=8", "--malloc-trim", "--background-index", "--pch-storage=memory"},
          -- options to pass to nvim-lspconfig
          -- i.e. the arguments to require("lspconfig").clangd.setup({})
          on_attach = custom_attach,
          capabilities = clangd_capabilities,
          init_options = {
            usePlaceholders = true,
            completeUnimported = true
          },
          flags = {
            debounce_text_changes = 150
          }

      })

      -- require('clangd_extensions').setup({
      --   inlay_hints = {
      --     inline = vim.fn.has("nvim-0.10") == 1,
      --     -- Options other than `highlight' and `priority' only work
      --     -- if `inline' is disabled
      --     -- Only show inlay hints for the current line
      --     only_current_line = false,
      --     -- Event which triggers a refresh of the inlay hints.
      --     -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
      --     -- not that this may cause  higher CPU usage.
      --     -- This option is only respected when only_current_line and
      --     -- autoSetHints both are true.
      --     only_current_line_autocmd = { "CursorHold" },
      --     -- whether to show parameter hints with the inlay hints or not
      --     show_parameter_hints = true,
      --     -- prefix for parameter hints
      --     parameter_hints_prefix = "<- ",
      --     -- prefix for all the other hints (type, chaining)
      --     other_hints_prefix = "=> ",
      --     -- whether to align to the length of the longest line in the file
      --     max_len_align = false,
      --     -- padding from the left if max_len_align is true
      --     max_len_align_padding = 1,
      --     -- whether to align to the extreme right or not
      --     right_align = false,
      --     -- padding from the right if right_align is true
      --     right_align_padding = 7,
      --     -- The color of the hints
      --     highlight = "Comment",
      --     -- The highlight group priority for extmark
      --     priority = 100,
      --   },
      -- })

      -- require("clangd_extensions").setup {
      --   -- defaults:
      --   -- Automatically set inlay hints (type hints)
      --   autoSetHints = true,
      --   -- Whether to show hover actions inside the hover window
      --   -- This overrides the default hover handler
      --   hover_with_actions = true,
      --   -- These apply to the default ClangdSetInlayHints command
      --   inlay_hints = {
      --     -- Only show inlay hints for the current line
      --     only_current_line = false,
      --     -- Event which triggers a refersh of the inlay hints.
      --     -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
      --     -- not that this may cause  higher CPU usage.
      --     -- This option is only respected when only_current_line and
      --     -- autoSetHints both are true.
      --     only_current_line_autocmd = "CursorHold",
      --     -- whether to show parameter hints with the inlay hints or not
      --     show_parameter_hints = true,
      --     -- whether to show variable name before type hints with the inlay hints or not
      --     show_variable_name = false,
      --     -- prefix for parameter hints
      --     parameter_hints_prefix = "<- ",
      --     -- prefix for all the other hints (type, chaining)
      --     other_hints_prefix = "=> ",
      --     -- whether to align to the length of the longest line in the file
      --     max_len_align = false,
      --     -- padding from the left if max_len_align is true
      --     max_len_align_padding = 1,
      --     -- whether to align to the extreme right or not
      --     right_align = false,
      --     -- padding from the right if right_align is true
      --     right_align_padding = 7,
      --     -- The color of the hints
      --     highlight = "Comment"
      --   },
      --   ast = {
      --     role_icons = {
      --       type = "",
      --       declaration = "",
      --       expression = "",
      --       specifier = "",
      --       statement = "",
      --       ["template argument"] = ""
      --     },
      --     kind_icons = {
      --       Compound = "",
      --       Recovery = "",
      --       TranslationUnit = "",
      --       PackExpansion = "",
      --       TemplateTypeParm = "",
      --       TemplateTemplateParm = "",
      --       TemplateParamObject = ""
      --     },
      --     highlights = {
      --       detail = "Comment"
      --     }
      --   }
      -- }

      -- lspconfig.grammar_guard.setup(
      --   {
      --     cmd = {env_vars.HOME .. "/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls"}, -- add this if you install ltex-ls yourself
      --     settings = {
      --       ltex = {
      --         enabled = {"latex", "tex", "bib", "markdown", "pandoc", "vimwiki"},
      --         language = {"en", "fr"},
      --         diagnosticSeverity = "information",
      --         setenceCacheSize = 2000,
      --         additionalRules = {
      --           enablePickyRules = true,
      --           motherTongue = "en"
      --         },
      --         trace = {server = "verbose"},
      --         dictionary = {},
      --         disabledRules = {},
      --         hiddenFalsePositives = {},
      --         completionEnabled = true
      --       }
      --     }
      --   }
      -- )

      if not configs.neocmake then
        configs.neocmake = {
          default_config = {
            cmd = { "neocmakelsp", "--stdio" },
            filetypes = { "cmake" },
            root_dir = function(fname)
              return lspconfig.util.find_git_ancestor(fname)
            end,
            single_file_support = true,       -- suggested
            on_attach = custom_attach             -- on_attach is the on_attach function you defined
          }
        }
        lspconfig.neocmake.setup({})
      end

      -- lspconfig.cmake.setup {
      --   on_attach = custom_attach,
      --   flags = {
      --     debounce_text_changes = 150
      --   }
      -- }

      lspconfig.bashls.setup {
        on_attach = custom_attach,
        flags = {
          debounce_text_changes = 150
        }
      }

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
          'pyproject.toml',
          'setup.py',
          'setup.cfg',
          'requirements.txt',
          'Pipfile',
          'pyrightconfig.json',
          '.git',
        }

        configs.pylance = {
            default_config = {
              cmd = { "delance-langserver", "--stdio" },
              filetypes = { "python" },
              root_dir = function(fname)
                return lspconfig.util.root_pattern(unpack(root_files))(fname)
              end,
              single_file_support = true,       -- suggested
              on_attach = custom_attach             -- on_attach is the on_attach function you defined
            },
        }
      end

      lspconfig.pylance.setup{
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
      }

      -- lspconfig.basedpyright.setup({
      --   capabilities = capabilities,
      --   settings = {
      --     basedpyright = {
      --       python = {
      --         pythonPath = "/usr/bin/python3",
      --         analysis = {
      --           typeCheckingMode = "standard",
      --           autoImportCompletion = true,
      --           inlayHints = {
      --             variableTypes = true,
      --             functionReturnTypes = true,
      --             callArgumentNames = true,
      --           },
      --         },
      --       },
      --     },
      --   },
      -- })

      -- lspconfig.jedi_language_server.setup{}

      -- lspconfig.jedi_language_server.setup{
      --     on_attach=custom_attach,
      --     flags = {
      --       debounce_text_changes = 150,
      --     },
      -- }

      -- way too slow
      -- lspconfig.pylsp.setup{
      --   on_attach = custom_attach,
      --   flags = {
      --     debounce_text_changes = 150
      --   }
      -- }

      lspconfig.texlab.setup {
        on_attach = custom_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150
        }
      }

      lspconfig.jsonls.setup {
        on_attach = custom_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150
        }
      }

      lspconfig.vimls.setup {
        on_attach = custom_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150
        }
      }


      -- require("neodev").setup({
      --     library = { plugins = { "nvim-dap-ui" }, types = true },
      -- })

      lspconfig.lua_ls.setup(
        -- {
        --   settings = {
        --     Lua = {
        --       completion = {
        --         callSnippet = "Replace"
        --       },
        --       hint = {
        --         enable = true
        --       }
        --     }
        --   }
        -- }

        {
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
        }
      )

      -- C#
      local pid = vim.fn.getpid()
      local omnisharp_bin = "/usr/bin/omnisharp"

      lspconfig.omnisharp.setup {
        cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid)},
        flags = {
          debounce_text_changes = 150
        }
      }

      -- Web
      lspconfig.html.setup {
        on_attach = custom_attach,
        filetypes = {'html', 'htmldjango'},
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150
        }
      }


      lspconfig.cssls.setup {
        on_attach = custom_attach,
        flags = {
          debounce_text_changes = 150
        }
      }

      local extension_path = env_vars.HOME .. ".vscode-oss/extensions/vadimcn.vscode-lldb-1.6.10/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {"documentation", "detail", "additionalTextEdits"}
      }

      local opts = {
        tools = {
          -- rust-tools options
          -- Automatically set inlay hints (type hints)
          autoSetHints = true,
          -- Whether to show hover actions inside the hover window
          -- This overrides the default hover handler
          -- hover_with_actions = true,

          -- how to execute terminal commands
          -- options right now: termopen / quickfix
          executor = require("rust-tools/executors").termopen,
          runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
          },
          debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
          },
          -- These apply to the default RustSetInlayHints command
          inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- whether to show variable name before type hints with the inlay hints or not
            show_variable_name = false,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment"
          },
          hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
            -- whether the hover action window gets automatically focused
            auto_focus = false
          },
          -- settings for showing the crate graph based on graphviz and the dot
          -- command
          crate_graph = {
            -- Backend used for displaying the graph
            -- see: https://graphviz.org/docs/outputs/
            -- default: x11
            backend = "x11",
            -- where to store the output, nil for no output stored (relative
            -- path from pwd)
            -- default: nil
            output = nil,
            -- command to pipe the output to, nil for no piping
            pipe = nil,
            -- NOTE: Be careful when using pipe and output together
            -- true for all crates.io and external crates, false only the local
            -- crates
            -- default: true
            full = true
          }
        },
        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
        server = {
          -- cmd = {"/home/j_mudo/repos/ra-multiplex/target/release/ra-multiplex-server", "&", "/home/j_mudo/repos/ra-multiplex/target/release/ra-multiplex"},
          capabilities = capabilities,
          -- standalone file support
          -- setting it to false may improve startup time
          standalone = true
        }, -- rust-analyer options
        -- debugging stuff
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
        }
      }

      require("rust-tools").setup(opts)
      require("rust-tools").inlay_hints.set()
      require("rust-tools").inlay_hints.enable()

      -- lspconfig.rust_analyzer.setup {
      --   capabilities = capabilities,
      --   completion = {
      --     autoimport = {
      --       enable = true
      --     },
      --   },
      --   flags = {
      --     debounce_text_changes = 150,
      --   }
      -- }

      -- lspconfig.svls.setup{
      --   on_attach = custom_attach
      -- }

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

      -- if not configs.rust_hdl then
      --   configs.rust_hdl = {
      --     default_config = {
      --       cmd = {'/home/j_mudo/repos/rust_hdl/target/release/vhdl_ls'};
      --       filetypes = { "vhdl" };
      --       root_dir = function(fname)
      --         return lspconfig.util.root_pattern('vhdl_ls.toml')(fname) or lspconfig.util.path.dirname(fname)
      --       end;
      --       settings = {};
      --     };
      --   }
      -- end

      -- Manual add rust_hdl server
      if not configs.rust_hdl then
        configs.rust_hdl = {
          default_config = {
            capabilities = capabilities,
            cmd = {"/home/j_mudo/repos/rust_hdl/target/release/vhdl_ls"},
            filetypes = {"vhdl"},
            root_dir = function(fname)
              return lspconfig.util.root_pattern("vhdl_ls.toml")(fname) or util.find_git_ancestor(fname)
            end,
            settings = {}
          }
        }
      end

      lspconfig.rust_hdl.setup {
        on_attach = custom_attach
      }

      lspconfig.lemminx.setup({
          on_attach = custom_attach,
          settings = {
              xml = {
                  catalogs = { "/etc/xml/catalog" }
              }
          }
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
        local Path = require 'plenary.path'

        local path = Path:new(filename)
        if not path:exists() then
          return nil
        end

        local json_contents = path:read()
        local json = vim.fn.json_decode(json_contents)

        return json
      end

      local function read_package_json()
        return read_json_file('package.json')
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
        local global_ts = '/home/'.. env_vars.USER ..'/.nvm/versions/node/v20.12.2/lib/node_modules/typescript/lib'
        -- Alternative location if installed as root:
        -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
        local found_ts = ''
        local function check_dir(path)
          found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
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

      local vue_filetypes = { 'vue' }
      -- local have_vue = is_npm_package_installed('vue')
      local have_vue = false -- apparently volar doesn't wrap around tsserver anymore?
      if not have_vue then
        vue_filetypes = { 'vue', 'typescript', 'javascript', 'typescriptreact' }
      end

      lspconfig.volar.setup {
        on_attach = custom_attach,
        -- filetypes = vue_filetypes,
        capabilities = capabilities,
        on_new_config = function(new_config, new_root_dir)
          new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
        end,
        settings = {
          typescript = {
            preferences = {
              importModuleSpecifier = "non-relative"
            }
          },
          vue = {
            complete = {
              casing = {
                props = 'autoCamel',
              },
            },
          }
        },
      }

      if not have_vue then
        require("typescript-tools").setup {
          on_attach = custom_attach,
          flags = {
            debounce_text_changes = 150
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
              "@volar/vue-language-server"
            },
            expose_as_code_action = 'all',
            complete_function_calls = true,
          },
        }
      end

      lspconfig.svls.setup{
        filetypes = {"verilog", "systemverilog"},
        on_attach = custom_attach,
      }
      lspconfig.svlangserver.setup{
        on_attach = custom_attach,
        filetypes = {"verilog", "systemverilog"},
        settings = {
          systemverilog = {
            includeIndexing     = { "*.{v,vh,sv,svh}", "**/*.{v,vh,sv,svh}", "**/**/*.{v,vh,sv,svh}" },
            -- excludeIndexing     = {"test/**/*.sv*"},
            -- defines             = {},
            -- launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
            linter              = "verilator",
            formatCommand       = "verible-verilog-format --indentation_spaces=4"

          },
        },
      }

    -- require("mason-lspconfig").setup_handlers {
    --     -- The first entry (without a key) will be the default handler
    --     -- and will be called for each installed server that doesn't have
    --     -- a dedicated handler.
    --     function (server_name) -- default handler (optional)
    --         require("lspconfig")[server_name].setup {
    --           on_attach = custom_attach
    --         }
    --     end,
    --     -- Next, you can provide a dedicated handler for specific servers.
    --     -- For example, a handler override for the `rust_analyzer`:
    --     ["vuels"] = function ()
    --       require("lspconfig").vuels.setup({
    --         on_attach = custom_attach,
    --         completion = {
    --           autoImport = false,
    --         },
    --         format = {
    --           defaultFormatter = {
    --               js = 'eslint',
    --               -- ts = 'none',
    --             },
    --         }
    --       })
    --     end
    -- }

      -- if not configs.svlangserver then
      --     configs.svlangserver = {
      --       default_config = {
      --         cmd = {'svlangserver'},
      --         filetypes = {'verilog', 'systemverilog'},
      --         root_dir = function(fname)
      --           return util.find_git_ancestor(fname) or util.path.dirname(fname)
      --         end,
      --         settings = {}
      --       },
      --     }
      -- end
      -- lspconfig.svlangserver.setup{
      --   on_attach = custom_attach
      -- }

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
    end
  }
}
