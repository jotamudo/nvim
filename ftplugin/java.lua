    local env = vim.fn.environ()
    local home = env.HOME
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = { "documentation", "detail", "additionalTextEdits" },
    }

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

    local workspace_dir = '/home/j_mudo/projs/Java/' .. project_name

    local custom_attach = function(client)
      -- require'lsp_signature'.on_attach()
      -- if client.server_capabilities.document_highlight then
      --     vim.cmd [[
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
      if client.name == "pyright" then
        client.server_capabilities.completionProvider = false
      end

      print("Lsp ready")
    end


    local config = {
      -- The command that starts the language server
      -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
      capabilities = capabilities,

      cmd = { '/home/j_mudo/repos/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/bin/jdtls'},

      root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    }
    
    local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    config.init_options = {
      -- bundles = bundles;
      extendedClientCapabilities = extendedClientCapabilities;
    }
    -- This starts a new client & server,
    -- or attaches to an existing client & server depending on the `root_dir`.
    require('jdtls').start_or_attach(config)
