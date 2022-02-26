local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
local util = require('lspconfig.util')
local env_vars = vim.fn.environ()

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

-- See uses
local custom_attach = function(client)
  -- require'lsp_signature'.on_attach()
  print("Lsp ready")
end

-- QUALITY OF LIFE PLS
local saga = require 'lspsaga'

-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- error_header = "  Error",
-- warn_header = "  Warn",
-- hint_header = "  Hint",
-- infor_header = "  Infor",
-- max_diag_msg_width = 50,
-- code_action_icon = ' ',
-- code_action_keys = { quit = 'q',exec = '<CR>' }
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q'
-- },
-- definition_preview_icon = '  '
-- 1: thin border | 2: rounded border | 3: thick border
-- border_style = 1
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}
saga.init_lsp_saga()

require("clangd_extensions").setup {
    server = {
        -- options to pass to nvim-lspconfig
        -- i.e. the arguments to require("lspconfig").clangd.setup({})
        on_attach=custom_attach,
        capabilities = capabilities,
        init_options = {
          usePlaceholders = true,
          completeUnimported = true
        },
        flags = {
          debounce_text_changes = 150,
        }
    },
    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- Whether to show hover actions inside the hover window
        -- This overrides the default hover handler
        hover_with_actions = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
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
            highlight = "Comment",
        },
        ast = {
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },

            highlights = {
                detail = "Comment",
            },
      }
  }
}

lspconfig.grammar_guard.setup({
  cmd = { env_vars.HOME .. '/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls' }, -- add this if you install ltex-ls yourself
  settings = {
    ltex = {
      enabled = { "latex", "tex", "bib", "markdown", "pandoc", "vimwiki" },
      language = "en",
      diagnosticSeverity = "information",
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en",
      },
      trace = { server = "verbose" },
      dictionary = {},
      disabledRules = {},
      hiddenFalsePositives = {},
      completionEnabled = true,
    },
  },
})

lspconfig.cmake.setup{
  on_attach=custom_attach,
  flags = {
    debounce_text_changes = 150,
  }
}
lspconfig.bashls.setup{ 
  on_attach=custom_attach,
  flags = {
    debounce_text_changes = 150,
  }
}

lspconfig.pyright.setup{
  on_attach=custom_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      }
    }
  }
}

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


lspconfig.texlab.setup{
  on_attach=custom_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }
}

lspconfig.jsonls.setup{
    on_attach=custom_attach,
    capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }

}

lspconfig.vimls.setup{
  on_attach=custom_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }

}

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = env_vars.HOME .. "/repos/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/lua-language-server"

local luadev = require('lua-dev').setup({
  library = {
      vimruntime = true, -- runtime path
      types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
      plugins = true, -- installed opt or start plugins in packpath
      -- you can also specify the list of plugins to make available as a workspace library
      -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  lspconfig = {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        flags = {
          debounce_text_changes = 150,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    },
    on_attach = custom_attach
  }
})

lspconfig.sumneko_lua.setup(luadev)

-- C#
local pid = vim.fn.getpid()
local omnisharp_bin = '/usr/bin/omnisharp'

lspconfig.omnisharp.setup{
  cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid)},
  flags = {
    debounce_text_changes = 150,
  }
}

-- Web
lspconfig.html.setup{
    on_attach=custom_attach,
    capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }

}
lspconfig.tsserver.setup{
    on_attach=custom_attach,
  flags = {
    debounce_text_changes = 150,
  }
}
lspconfig.cssls.setup{
    on_attach=custom_attach,
  flags = {
    debounce_text_changes = 150,
  }
}

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

if not configs.hdl_checker then
  configs.hdl_checker = {
    default_config = {
      -- autostart = false, -- disabled auto start since I am giving rust_hdl a shot
      cmd = {"hdl_checker", "--lsp"};
      filetypes = { "vhdl", "verilog", "systemverilog" };
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
        -- return util.root_pattern('.hdl_checker.config')(fname) or util.path.dirname(fname)
      end;
      settings = {};
    };
  }
end

-- lspconfig.hdl_checker.setup{
--   on_attach = custom_attach
-- }


if not configs.rust_hdl then
  configs.rust_hdl = {
    default_config = {
      cmd = {'/home/j_mudo/repos/rust_hdl/target/release/vhdl_ls'};
      filetypes = { "vhdl" };
      root_dir = function(fname)
        return lspconfig.util.root_pattern('vhdl_ls.toml')(fname) or lspconfig.util.path.dirname(fname)
      end;
      settings = {};
    };
  }
end

-- lspconfig.rust_hdl.setup{
--   on_attach = custom_attach
-- }

if not configs.svlangserver then
    configs.svlangserver = {
      default_config = {
        cmd = {'svlangserver'},
        filetypes = {'verilog', 'systemverilog'},
        root_dir = function(fname)
          return util.find_git_ancestor(fname) or util.path.dirname(fname)
        end,
        settings = {}
      },
    }
end
lspconfig.svlangserver.setup{
  on_attach = custom_attach
}

-- EXPERIMENTAL


--lspconfig.ccls.setup{
  --on_attach=require'completion'.on_attach,
  --init_options = {
    --highlight = {
      --lsRanges = true;
    --}
  --},
  --capabilities = {
      --textDocument = {
          --completion = {
            --completionItem = {
              --snippetSupport = true
            --}
          --}
      --}
    --},
--}

