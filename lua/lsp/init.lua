local util = require 'lspconfig/util'
local lspconfig = require 'lspconfig'
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- See uses
local custom_attach = function(client)
  require'lsp_signature'.on_attach()
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

lspconfig.clangd.setup{
  on_attach=custom_attach,
  --capabilities = {
    --textDocument = {
      --completion = {
        --completionItem = {
          --snippetSupport = true
        --}
      --}
    --}
  --},
  --capabilities = capabilities,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true
  }
}

lspconfig.cmake.setup{ on_attach=custom_attach }
lspconfig.bashls.setup{ on_attach=custom_attach }
lspconfig.pyright.setup{
    root_dir = util.root_pattern(".",".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt");
    on_attach=custom_attach,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
            },
            diagnosticSeverityOverrides = {
                reportOptionalOperand = "error",
                reportUnusedImport = "warning",
                reportUntypedFunctionDecorator = "warning",
                reportUntypedClassDecorator = "warning"
                };

        };
    };
    handlers = {
      -- pyright ignores dynamicRegistration settings
      ['client/registerCapability'] = function(_, _, _, _)
        return {
          result = nil;
          error = nil;
        }
      end
    };
}


lspconfig.texlab.setup{
  on_attach=custom_attach,
  capabilities = capabilities,
}

lspconfig.jsonls.setup{
    on_attach=custom_attach,
    capabilities = capabilities
}

lspconfig.vimls.setup{
  on_attach=custom_attach,
  capabilities = capabilities,
}

-- lua things after removal of LspInstall

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

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

-- Web
lspconfig.html.setup{
    on_attach=custom_attach,
    capabilities = capabilities
}
lspconfig.tsserver.setup{
    on_attach=custom_attach,
}
lspconfig.cssls.setup{
    on_attach=custom_attach,
}

-- diagnostics (?)
--lspconfig.diagnosticls.setup{
    --filetypes = { "c", "sh" }
--}

--lspconfig.diagnosticls.setup {
--    on_attach=custom_attach,
--    update_on_insert = true,
--    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'scss', 'markdown', 'pandoc' },
--    init_options = {
--        linters = {
--            flake8 = {
--                debounce = 100,
--                sourceName = "flake8",
--                command = "flake8",
--                args = {
--                  "--format",
--                  "%(row)d:%(col)d:%(code)s:%(code)s: %(text)s",
--                  "%file"
--                },
--                formatPattern = {
--                  "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
--                  {
--                    line = 1,
--                    column = 2,
--                    message = {"[", 3, "] ", 5},
--                    security = 4
--                  }
--                },
--                securities = {
--                    E = "error",
--                    W = "warning",
--                    F = "info",
--                    B = "hint",
--                },
--            },
--            pylint = {
--                sourceName = "pylint",
--                command = "pylint",
--                args ={
--                    "--output-format",
--                    "text",
--                    "--score",
--                    "no",
--                    "--msg-template",
--                    "'{line}:{column}:{category}:{msg} ({msg_id}:{symbol})'",
--                    "%file"
--                },
--                formatPattern = {
--                    "^(\\d+?):(\\d+?):([a-z]+?):(.*)$",
--                    {
--                        line = 1,
--                        column = 2,
--                        security = 3,
--                        message = 4
--                    }
--                },
--                rootPatterns = {".git", "pyproject.toml", "setup.py"},
--                securities = {
--                    informational = "hint",
--                    refactor = "info",
--                    convention = "info",
--                    warning = "warning",
--                    error = "error",
--                    fatal = "error"
--                },
--                offsetColumn = 1,
--                formatLines = 1
--            },
--            eslint = {
--                command = 'eslint',
--                rootPatterns = { '.git' },
--                debounce = 100,
--                args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
--                sourceName = 'eslint',
--                parseJson = {
--                    errorsRoot = '[0].messages',
--                    line = 'line',
--                    column = 'column',
--                    endLine = 'endLine',
--                    endColumn = 'endColumn',
--                    message = '[eslint] ${message} [${ruleId}]',
--                    security = 'severity'
--                },
--                securities = {
--                    [2] = 'error',
--                    [1] = 'warning'
--                }
--            },
--            markdownlint = {
--                command = 'markdownlint',
--                rootPatterns = { '.git' },
--                isStderr = true,
--                debounce = 100,
--                args = { '--stdin' },
--                offsetLine = 0,
--                offsetColumn = 0,
--                sourceName = 'markdownlint',
--                securities = {
--                    undefined = 'hint'
--                },
--                formatLines = 1,
--                formatPattern = {
--                    '^.*:(\\d+)\\s+(.*)$',
--                    {
--                        line = 1,
--                        column = -1,
--                        message = 2,
--                    }
--                }
--            },
--        },
--        filetypes = {
--            --python = 'pylint',
--            javascript = 'eslint',
--            javascriptreact = 'eslint',
--            typescript = 'eslint',
--            typescriptreact = 'eslint',
--            markdown = 'markdownlint',
--            pandoc = 'markdownlint'
--        },
--        formatters = {
--            prettierEslint = {
--                command = 'prettier-eslint',
--                args = { '--stdin' },
--                rootPatterns = { '.git' },
--            },
--            prettier = {
--                command = 'prettier',
--                args = { '--stdin-filepath', '%filename' }
--            }
--        },
--        formatFiletypes = {
--            css = 'prettier',
--            javascript = 'prettierEslint',
--            javascriptreact = 'prettierEslint',
--            json = 'prettier',
--            scss = 'prettier',
--            typescript = 'prettierEslint',
--            typescriptreact = 'prettierEslint'
--        }
--    },
--}

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  completion = {
    autoimport = {
      enable = true
    },
  },
}

-- EXPERIMENTAL

--local nvim_lsp = require('lspconfig')

--require 'pylance'
--nvim_lsp.pylance.setup{
    --settings = {
        --python = {
            --analysis = {
                --typeCheckingMode = "basic"
            --},
        --}
    --},
    --handlers = {
      ---- pyright ignores dynamicRegistration settings
      --['client/registerCapability'] = function(_, _, _, _)
        --return {
            --result = nil;
            --error = nil;
        --}
      --end
    --};
--}


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

