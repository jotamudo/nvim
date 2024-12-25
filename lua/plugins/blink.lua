return {
    {
        'saghen/blink.compat',
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = '*',
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {
            impersonate_nvim_cmp = true,
        },
    },
    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        -- enabled = false,
        -- optional: provides snippets for the snippet source
        dependencies = {
            'saghen/blink.compat',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-calc',
            'f3fora/cmp-spell',
            'rcarriga/cmp-dap',
            'dmitmel/cmp-digraphs',
            'uga-rosa/cmp-dictionary',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'quangnguyen30192/cmp-nvim-tags',
            -- 'delphinus/cmp-ctags',
            'ray-x/cmp-treesitter',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'onsails/lspkind-nvim',
            'saadparwaiz1/cmp_luasnip',
            'L3M0N4D3/LuaSnip',
            'jmbuhr/otter.nvim',
            'rafamadriz/friendly-snippets',
        },

        -- use a release tag to download pre-built binaries
        -- version = 'v0.*',
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        build = 'cargo build --release',
        -- On musl libc based systems you need to add this flag
        -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',

        opts = {
            sources = {
                default = {
                    'lsp',
                    'path',
                    'snippets',
                    'buffer',
                    -- nvim-cmp compat
                    'calc',
                    'emoji',
                    'tags',
                    'spell',
                },
                providers = {
                    calc = {
                        name = 'calc',
                        module = 'blink.compat.source',
                    },
                    emoji = {
                        name = 'emoji',
                        module = 'blink.compat.source',
                    },
                    tags = {
                        name = 'tags',
                        module = 'blink.compat.source',
                    },
                    spell = {
                        name = 'spell',
                        module = 'blink.compat.source',
                    },
                },
            },
            snippets = {
                expand = function(snippet)
                    require('luasnip').lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require('luasnip').jumpable(filter.direction)
                    end
                    return require('luasnip').in_snippet()
                end,
                jump = function(direction)
                    require('luasnip').jump(direction)
                end,
            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono',
            },
            -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- adjusts spacing to ensure icons are aligned

            -- experimental auto-brackets support
            completion = {
                accept = { auto_brackets = { enabled = true } },
                ghost_text = {
                    enabled = true,
                },
                menu = { border = 'single' },
                documentation = { window = { border = 'single' } },
            },

            -- experimental signature help support
            signature = {
                enabled = true,
                window = { border = 'single' },
            },
            keymap = {
                preset = 'default',
                ['<C-j>'] = { 'snippet_forward', 'fallback' },
                ['<C-k>'] = { 'snippet_backward', 'fallback' },
                cmdline = {
                  preset = 'enter',
                }
            },
        },
    },
}
