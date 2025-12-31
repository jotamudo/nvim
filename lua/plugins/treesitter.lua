return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'VeryLazy' },
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treesitter** module to be loaded in time.
        -- Luckily, the only things that those plugins need are the custom queries, which we make available
        -- during startup.
        require('lazy.core.loader').add_to_rtp(plugin)
        require('nvim-treesitter.query_predicates')
    end,
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = 'all', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
            ignore_install = {"ipkg"},
            highlight = {
                enable = true, -- false will disable the whole extension
                --additional_vim_regex_highlighting = { "markdown" }
                use_languagetree = false,
                disable = function(_, bufnr)
                    if vim.bo.filetype == 'markdown' then
                        return false
                    end

                    local buf_name = vim.api.nvim_buf_get_name(bufnr)
                    local file_size =
                        vim.api.nvim_call_function('getfsize', { buf_name })
                    return file_size > (256 * 4096)
                end,
            },
            -- tag = 'v0.9.2',
            --indent = {
            --enable = true
            --}
        })
    end,
}
