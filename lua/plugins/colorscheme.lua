local select_colorscheme = function()
    vim.o.termguicolors = true
    vim.cmd.colorscheme('gruvbox')
    vim.o.background = 'light'
    -- Disables background colors
    -- vim.cmd('hi! Normal ctermbg=None guibg=None')
end

return {
    {
        'ellisonleao/gruvbox.nvim',
        -- enabled = false,
        priority = 1001,
        config = function()
            require('gruvbox').setup()
            select_colorscheme()
        end,
    },
    { 'folke/tokyonight.nvim' },
    {
        'p00f/alabaster.nvim',
        config = function()
            select_colorscheme()
        end,
    },
    {
        'maxmx03/solarized.nvim',
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)
            require('solarized').setup(opts)
            select_colorscheme()
        end,
    },
}
