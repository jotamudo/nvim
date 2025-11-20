local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
local util = require('lspconfig.util')
local env_vars = vim.fn.environ()

vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
vim.cmd(
    [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
)

local border = {
    { '🭽', 'FloatBorder' },
    { '▔', 'FloatBorder' },
    { '🭾', 'FloatBorder' },
    { '▕', 'FloatBorder' },
    { '🭿', 'FloatBorder' },
    { '▁', 'FloatBorder' },
    { '🭼', 'FloatBorder' },
    { '▏', 'FloatBorder' },
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- change diagnostic symbols
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local icons = {
    Class = ' ',
    Color = ' ',
    Constant = ' ',
    Constructor = ' ',
    Enum = '了 ',
    EnumMember = ' ',
    Field = ' ',
    File = ' ',
    Folder = ' ',
    Function = ' ',
    Interface = 'ﰮ ',
    Keyword = ' ',
    Method = 'ƒ ',
    Module = ' ',
    Property = ' ',
    Snippet = '﬌ ',
    Struct = ' ',
    Text = ' ',
    Unit = ' ',
    Value = ' ',
    Variable = ' ',
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
    kinds[i] = icons[kind] or kind
end

-- customize diagnostic info
vim.diagnostic.config({
    virtual_text = {
        source = 'always',
        prefix = '●',
    },
    float = {
        source = 'always',
    },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
})

-- show diagnostic on cursor on floating window
vim.o.updatetime = 250
vim.cmd(
    [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
)

--Enable (broadcasting) snippet capability for completion
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

-- See uses
local custom_attach = function(client)
    -- require'lsp_signature'.on_attach()
    if client.server_capabilities.document_highlight then
        vim.cmd([[
        hi! LspReferenceRead cterm=bold ctermbg=red guibg=#282828
        hi! LspReferenceText cterm=bold ctermbg=red guibg=#282828
        hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#282828
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]])
    end
    -- if client.name == "pyright" then
    --   client.server_capabilities.completionProvider = false
    -- end

    print('Lsp ready')
end

require('clangd_extensions').setup({})

_set_ltex_lang = function(lang)
    local clients = vim.lsp.get_clients({ buffer = 0 })
    for _, client in ipairs(clients) do
        if client.name == 'ltex' then
            utils.notify(
                'Set ltex-ls lang to ' .. lang,
                vim.log.levels.INFO,
                'utils.functions'
            )
            client.config.settings.ltex.language = lang
            vim.lsp.buf_notify(
                0,
                'workspace/didChangeConfiguration',
                { settings = client.config.settings }
            )
            return
        end
    end
end

vim.api.nvim_create_user_command(
    'LtexLang',
    'lua _set_ltex_lang(<q-args>)',
    { nargs = 1, desc = 'Set ltex-ls language' }
)

lspconfig.ltex.setup({
    settings = {
        ltex = {
            language = 'en-US',
        },
    },
})

-- lspconfig.grammar_guard.setup({
--   cmd = { env_vars.HOME .. '/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls' }, -- add this if you install ltex-ls yourself
--   settings = {
--     ltex = {
--       enabled = { "latex", "tex", "bib", "markdown", "pandoc", "vimwiki" },
--       language = {"en", "fr"},
--       diagnosticSeverity = "information",
--       setenceCacheSize = 2000,
--       additionalRules = {
--         enablePickyRules = true,
--         motherTongue = "en",
--       },
--       trace = { server = "verbose" },
--       dictionary = {},
--       disabledRules = {},
--       hiddenFalsePositives = {},
--       completionEnabled = true,
--     },
--   },
-- })
--
lspconfig.cmake.setup({
    on_attach = custom_attach,
    flags = {
        debounce_text_changes = 150,
    },
})
lspconfig.bashls.setup({
    on_attach = custom_attach,
    flags = {
        debounce_text_changes = 150,
    },
})

lspconfig.pyright.setup({
    on_attach = custom_attach,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'off',
            },
        },
    },
})

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

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use

require('neodev').setup({
    -- add any options here, or leave empty to use the default settings
})

lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
        },
    },
})

-- C#
local pid = vim.fn.getpid()
local omnisharp_bin = '/usr/bin/omnisharp'

lspconfig.omnisharp.setup({
    cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
    flags = {
        debounce_text_changes = 150,
    },
})

-- Web
lspconfig.html.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
})
lspconfig.tsserver.setup({
    on_attach = custom_attach,
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

local extension_path = env_vars.HOME
    .. '.vscode-oss/extensions/vadimcn.vscode-lldb-1.6.10/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
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
        executor = require('rust-tools/executors').termopen,
        runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true,

            -- rest of the opts are forwarded to telescope
        },
        debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true,

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
            only_current_line_autocmd = 'CursorHold',
            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- whether to show variable name before type hints with the inlay hints or not
            show_variable_name = false,
            -- prefix for parameter hints
            parameter_hints_prefix = '<- ',
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = '=> ',
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = 'Comment',
        },
        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                { '╭', 'FloatBorder' },
                { '─', 'FloatBorder' },
                { '╮', 'FloatBorder' },
                { '│', 'FloatBorder' },
                { '╯', 'FloatBorder' },
                { '─', 'FloatBorder' },
                { '╰', 'FloatBorder' },
                { '│', 'FloatBorder' },
            },
            -- whether the hover action window gets automatically focused
            auto_focus = false,
        },
        -- settings for showing the crate graph based on graphviz and the dot
        -- command
        crate_graph = {
            -- Backend used for displaying the graph
            -- see: https://graphviz.org/docs/outputs/
            -- default: x11
            backend = 'x11',
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
            full = true,
        },
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- cmd = {"/home/j_mudo/repos/ra-multiplex/target/release/ra-multiplex-server", "&", "/home/j_mudo/repos/ra-multiplex/target/release/ra-multiplex"},
        capabilities = capabilities,
        -- standalone file support
        -- setting it to false may improve startup time
        standalone = true,
    }, -- rust-analyer options
    -- debugging stuff
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path,
            liblldb_path
        ),
    },
}

require('rust-tools').setup(opts)

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
            cmd = { '/home/j_mudo/repos/rust_hdl/target/release/vhdl_ls' },
            filetypes = { 'vhdl' },
            root_dir = function(fname)
                return lspconfig.util.root_pattern('vhdl_ls.toml')(fname)
                    or util.find_git_ancestor(fname)
            end,
            settings = {},
        },
    }
end

lspconfig.rust_hdl.setup({
    on_attach = custom_attach,
})

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
